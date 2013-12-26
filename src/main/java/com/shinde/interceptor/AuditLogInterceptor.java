package com.shinde.interceptor;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.hibernate.CallbackException;
import org.hibernate.EmptyInterceptor;
import org.hibernate.Session;
import org.hibernate.type.Type;

import com.shinde.util.AuditLogUtil;

@SuppressWarnings("serial")
public class AuditLogInterceptor extends EmptyInterceptor{

	Session session;
	@SuppressWarnings("rawtypes")
	private final Set inserts = new HashSet();
	@SuppressWarnings("rawtypes")
	private final Set updates = new HashSet();
	@SuppressWarnings("rawtypes")
	private final Set deletes = new HashSet();

	public void setSession(Session session) {
		this.session=session;
	}

	@Override
	@SuppressWarnings("unchecked")
	public boolean onSave(Object entity,Serializable id,
			Object[] state,String[] propertyNames,Type[] types)
					throws CallbackException {

		System.out.println("onSave");

		if (entity instanceof IAuditLog){
			inserts.add(entity);
		}
		return false;

	}

	@Override
	@SuppressWarnings("unchecked")
	public boolean onFlushDirty(Object entity,Serializable id,
			Object[] currentState,Object[] previousState,
			String[] propertyNames,Type[] types)
					throws CallbackException {

		System.out.println("onFlushDirty");

		if (entity instanceof IAuditLog){
			updates.add(entity);
		}
		return false;

	}

	@Override
	@SuppressWarnings("unchecked")
	public void onDelete(Object entity, Serializable id,
			Object[] state, String[] propertyNames,
			Type[] types) {

		System.out.println("onDelete");

		if (entity instanceof IAuditLog){
			deletes.add(entity);
		}
	}

	//called before commit into database
	@Override
	@SuppressWarnings("rawtypes")
	public void preFlush(Iterator iterator) {
		System.out.println("preFlush");
	}

	//called after committed into database
	@Override
	@SuppressWarnings({ "rawtypes", "deprecation" })
	public void postFlush(Iterator iterator) {
		System.out.println("postFlush");

		try{

			for (Iterator it = inserts.iterator(); it.hasNext();) {
				IAuditLog entity = (IAuditLog) it.next();
				System.out.println("postFlush - insert");

				AuditLogUtil.LogIt("Saved",entity, session.connection());
			}

			for (Iterator it = updates.iterator(); it.hasNext();) {
				IAuditLog entity = (IAuditLog) it.next();
				System.out.println("postFlush - update");
				AuditLogUtil.LogIt("Updated",entity, session.connection());
			}

			for (Iterator it = deletes.iterator(); it.hasNext();) {
				IAuditLog entity = (IAuditLog) it.next();
				System.out.println("postFlush - delete");
				AuditLogUtil.LogIt("Deleted",entity, session.connection());
			}

		} finally {
			inserts.clear();
			updates.clear();
			deletes.clear();
		}
	}

}
