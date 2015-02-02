package com.lishunan.gpm;

/**
 * Created by Administrator on 2015/2/2.
 */
public class People {
    private String account;
    private String password;
    private String name;
    private String type;

    public void setAccount (String account) {
        this.account = account;
    }
    public void setPassword (String password) {
        this.password = password;
    }
    public void setName (String name) {
        this.name = name;
    }
    public void setType (String type) {
        this.type = type;
    }

    public String getAccount () {
        return account;
    }
    public String getPassword () {
        return password;
    }
    public String getName () {
        return name;
    }
    public String getType () {
        return type;
    }

}