package com.wy.entity;

import com.github.pagehelper.PageInfo;

import java.util.Objects;


/**
 * layui table数据表格需要的数据格式
 * @param <T>
 */
public class DataModel<T> {
    private Integer code = 0; //状态码
    private String msg = "操作成功!"; //提示信息
    private Long count; //数据总条数
    private T data; //数据


    @Override
    public String toString() {
        return "DataModel{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", count=" + count +
                ", data=" + data +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DataModel<?> dataModel = (DataModel<?>) o;
        return Objects.equals(code, dataModel.code) &&
                Objects.equals(msg, dataModel.msg) &&
                Objects.equals(count, dataModel.count) &&
                Objects.equals(data, dataModel.data);
    }

    @Override
    public int hashCode() {

        return Objects.hash(code, msg, count, data);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public DataModel(Integer code, String msg, Long count, T data) {

        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public DataModel() {

    }

    public DataModel(Integer code, String message) {
        this.code = code;
        this.msg = message;
    }

    public DataModel(String message, T t) {
        this.msg = message;
        this.data = t;
    }

    /**
     * 将分页对象的数据存放到当前对象中
     * @param pageInfo
     */
    public DataModel(PageInfo pageInfo){
        this.count  = pageInfo.getTotal();
        this.data = (T )pageInfo.getList();
    }

    public DataModel(T t) {
        this.data = t;
    }
}
