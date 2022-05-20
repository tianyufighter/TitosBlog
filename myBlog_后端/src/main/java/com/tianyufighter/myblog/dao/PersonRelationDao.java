package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.PersonRelation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface PersonRelationDao {
    /**
     * 插入联系人
     */
    int insertPerson(PersonRelation personRelation);

    /**
     * 查询用户所有的联系人
     */
    List<PersonRelation> queryPerson(@Param("myName") String myName);

    /**
     * 查询数据库中是否有该联系人
     */
    PersonRelation queryPersonByName(@Param("myName") String myName, @Param("friendName") String friendName);
    /**
     * 根据联系人双方的名称删除该条关系
     */
    int deleteLiaison(@Param("myName") String myName, @Param("friendName") String friendName);
    /**
     * 根据联系人双方的姓名更新最后发送的消息
     */
    int updateMessage(@Param("myName") String myName, @Param("friendName") String friendName, @Param("message") String message, @Param("sendTime") Date sendTime);
}
