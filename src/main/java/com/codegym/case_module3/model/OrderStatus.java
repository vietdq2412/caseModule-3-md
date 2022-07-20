package com.codegym.case_module3.model;

public class OrderStatus {
    private int id;
    private String name;

    public OrderStatus() {
    }

    public OrderStatus(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public OrderStatus(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
