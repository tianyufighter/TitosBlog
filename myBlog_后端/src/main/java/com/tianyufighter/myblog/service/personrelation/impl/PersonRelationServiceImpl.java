package com.tianyufighter.myblog.service.personrelation.impl;

import com.tianyufighter.myblog.dao.PersonRelationDao;
import com.tianyufighter.myblog.model.PersonRelation;
import com.tianyufighter.myblog.service.personrelation.PersonRelationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
@Service
public class PersonRelationServiceImpl implements PersonRelationService {
    @Resource
    private PersonRelationDao personRelationDao;
    @Override
    public int insertPerson(PersonRelation personRelation) {
        return personRelationDao.insertPerson(personRelation);
    }

    @Override
    public List<PersonRelation> queryPerson(String myName) {
        return personRelationDao.queryPerson(myName);
    }

    @Override
    public PersonRelation queryPersonByName(String myName, String friendName) {
        return personRelationDao.queryPersonByName(myName, friendName);
    }

    @Override
    public int deleteLiaison(String myName, String friendName) {
        return personRelationDao.deleteLiaison(myName, friendName);
    }

    @Override
    public int updateMessage(String myName, String friendName, String message, Date sendTime) {
        return personRelationDao.updateMessage(myName, friendName, message, sendTime);
    }
}
