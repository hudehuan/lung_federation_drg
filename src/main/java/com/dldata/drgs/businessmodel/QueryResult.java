package com.dldata.drgs.businessmodel;

import java.util.List;

/**
 * Created by zhangyy on 2017-04-12.
 */
public class QueryResult<T> {

    private Long totalrecord;

    private List resultlist;

    public Long getTotalrecord() {
        return totalrecord;
    }

    public void setTotalrecord(Long totalrecord) {
        this.totalrecord = totalrecord;
    }

    public List getResultlist() {
        return resultlist;
    }

    public void setResultlist(List resultlist) {
        this.resultlist = resultlist;
    }
}
