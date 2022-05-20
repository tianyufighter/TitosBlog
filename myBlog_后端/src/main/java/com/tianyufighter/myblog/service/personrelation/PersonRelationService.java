package com.tianyufighter.myblog.service.personrelation;

import com.tianyufighter.myblog.model.PersonRelation;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface PersonRelationService {
    /**
     * 插入联系人
     */
    int insertPerson(PersonRelation personRelation);

    /**
     * 查询用户所有的联系人
     */
    List<PersonRelation> queryPerson(String myName);

    /**
     * 查询数据库中是否有该联系人
     */
    PersonRelation queryPersonByName(String myName, String friendName);
    /**
     * 根据联系人双方的名称删除该条关系
     */
    int deleteLiaison(String myName, String friendName);
    /**
     * 根据联系人双方的姓名更新最后发送的消息
     */
    int updateMessage(String myName, String friendName, String message, Date sendTime);
}
