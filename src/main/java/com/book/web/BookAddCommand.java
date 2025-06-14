package com.book.web;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BookAddCommand {


    private String name;
    private String author;
    private String publish;
    private String isbn;
    private String introduction;
    private String language;
    private BigDecimal price;
    private Date pubdate;
    private int classId;
    private int pressmark;
    private int state;

    public void setName(String name) {
        this.name = name;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setPubdate(String pubdate) {
        if (pubdate == null || pubdate.trim().isEmpty()) {
            this.pubdate = new Date(); // 设置默认日期
            return;
        }
        
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

        try{
            java.util.Date date=sdf.parse(pubdate.trim());
            this.pubdate=date;
        }catch (ParseException e){
            e.printStackTrace();
            this.pubdate = new Date(); // 解析失败时设置默认日期
        }

    }

    public void setPublish(String publish) {
        this.publish = publish;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public void setPrice(String price) {
        try {
            if (price != null && !price.trim().isEmpty()) {
                this.price = new BigDecimal(price.trim());
            } else {
                this.price = BigDecimal.ZERO;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            this.price = BigDecimal.ZERO;
        }
    }

    public void setPressmark(int pressmark) {
        this.pressmark = pressmark;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }


    public int getClassId() {
        return classId;
    }

    public Date getPubdate() {
        return pubdate;
    }

    public String getAuthor() {
        return author;
    }

    public String getIntroduction() {
        return introduction;
    }

    public int getPressmark() {
        return pressmark;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getLanguage() {
        return language;
    }

    public int getState() {
        return state;
    }

    public String getPublish() {
        return publish;
    }



}
