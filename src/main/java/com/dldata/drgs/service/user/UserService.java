package com.dldata.drgs.service.user;


import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * Created by 倪继文 on 2016/6/21.
 */

@Component
@Transactional
public class UserService {

    @PersistenceContext
    private EntityManager em;

//    @Autowired
//    private UsersDao userDao;




//
//    public UsersEntity save(UsersEntity user){
//        return  userDao.save(user);
//    }
//
//
//    public List<UsersEntity> getAll(){
//
//
//        return userDao.getAll();
//
//    }
//
//    public UsersEntity getUserById(int id){
//
//        UsersEntity user = userDao.getUserById(id);
//
//        return user;
//    }
//
//    public void deleteUserById(int id){
//        userDao.delete(id);
//    }
//
//
//    /*
//    * 构建自定义SQL查询
//    * */
//    public Page<UsersEntity> getUserList(int pageNumber,int pageSize){
//
//        String hql = "select t from UsersEntity  t";
//
//
//        hql = hql+" order by t.id desc ";
//
//        Query q = em.createQuery(hql);
//        //List t = q.getResultList();
//        Integer Total = q.getResultList().size(); //查询结果总数
//        q.setFirstResult((pageNumber-1)*pageSize);
//        q.setMaxResults(pageSize);
//
//        Page<UsersEntity> page1 = new PageImpl<UsersEntity>(q.getResultList(),new PageRequest(pageNumber-1,q.getMaxResults()),Total);
//        return page1;
//
//    }
//
//
//    /*
//    * EQ 相等, LIKE, GT 大于, LT 小于, GTE 大于等于, LTE 小于等
//    *
//    *
//    * */
//    public Page<UsersEntity> getUserList2(  int pageNumber, int pageSize){
//        Map<String, SearchFilter> filters = new HashMap<String, SearchFilter>();
//        //查询条件
//        filters.put("age", new SearchFilter("age", SearchFilter.Operator.GT,1));
//
//        Specification<UsersEntity> spec = DynamicSpecifications.bySearchFilter(filters.values(), UsersEntity.class);
//        Sort sort = new Sort(Sort.Direction.DESC, "id");
//
//        PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, sort);
//        //List<UsersEntity> users = userDao.findAll(spec);//不分页
//        return userDao.findAll(spec,pageRequest);//分页查询
//
//
//    }
//
//
//    public List<UsersEntity>  getUserByName(String name){
//        return userDao.getUsersByName(1,"%"+name+"%");//like条件查询
//    }
//
//
//
//    public void update(UsersEntity user){
//        userDao.save(user);
//    }
//
//    public void delete(UsersEntity user){
//        userDao.delete(user);
//    }
//

}
