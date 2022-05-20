package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Searchdata {
    private int id;
    private String searchRecord;
    private int num;
    public Searchdata(String searchRecord, int num) {
        this.searchRecord = searchRecord;
        this.num = num;
    }
}
