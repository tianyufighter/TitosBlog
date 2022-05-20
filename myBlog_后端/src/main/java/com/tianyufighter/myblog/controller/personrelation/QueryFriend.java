package com.tianyufighter.myblog.controller.personrelation;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.PersonRelation;
import com.tianyufighter.myblog.service.personrelation.PersonRelationService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class QueryFriend {
    @Resource
    private PersonRelationService personRelationService;

    @RequestMapping("/relation/queryFriend")
    public CommonResult<List<PersonRelation>> queryFriend(String myName) {
        List<PersonRelation> res = personRelationService.queryPerson(myName);
        if(res != null) {
            return new CommonResult<>(200, "数据查询成功", res);
        } else {
            return new CommonResult<>(444, "数据查询失败");
        }
    }
}
