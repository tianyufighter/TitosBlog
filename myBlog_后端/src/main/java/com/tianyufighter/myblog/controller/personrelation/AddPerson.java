package com.tianyufighter.myblog.controller.personrelation;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.PersonRelation;
import com.tianyufighter.myblog.service.personrelation.PersonRelationService;
import com.tianyufighter.myblog.service.user.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
public class AddPerson {
    @Resource
    private PersonRelationService personRelationService;
    @Resource
    private UserService userService;

    @RequestMapping("/relation/addPerson")
    public CommonResult addPerson(@Param("myName") String myName, @Param("friendName") String friendName) {
        String myPortrait = userService.queryHeadImage(myName);
        String friendPortrait = userService.queryHeadImage(friendName);
        // 查询数据库中是否已有此对联系人
        PersonRelation p = personRelationService.queryPersonByName(myName, friendName);
        if(p != null) {
            return new CommonResult(333, "数据库中已有此对联系人");
        }
        PersonRelation personRelation = new PersonRelation();
        personRelation.setMyName(myName);
        personRelation.setFriendName(friendName);
        personRelation.setMyPortrait(myPortrait);
        personRelation.setFriendPortrait(friendPortrait);
        personRelation.setMessage("");
        int res = personRelationService.insertPerson(personRelation);
        personRelation.setMyName(friendName);
        personRelation.setFriendName(myName);
        int res2 = personRelationService.insertPerson(personRelation);
        if(res == 1 && res2 == 1) {
            return new CommonResult(200, "添加成功");
        } else {
            return new CommonResult(444, "添加失败");
        }
    }
}
