package com.wy.vo;

import com.wy.entity.SysUser;
import lombok.Data;

/**
 * SysUser的扩展类.用于用户管理列表显式
 * @see com.wy.entity.SysUser
 */
@Data
public class SysUserVo extends SysUser {
    private String groupName;
}
