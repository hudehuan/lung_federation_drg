package com.dldata.drgs.businessmodel;

import java.util.List;

/**
 * Created by 倪继文 on 2016/8/16.
 */
public class TreeNode {

    private String id;
    private String text;
    private String state;
    private List<TreeNode> children;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
