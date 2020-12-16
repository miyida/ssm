package com.wy.dao;

import com.wy.entity.SysGroupRule;

import java.util.List;

public interface SysGroupRuleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysGroupRule record);

    int insertSelective(SysGroupRule record);

    SysGroupRule selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysGroupRule record);

    int updateByPrimaryKey(SysGroupRule record);

    List<SysGroupRule> getGroupRuleByGroupId(Integer groupId);

    int delRulesByGroupId(Integer groupId);
}