package domain;

import java.util.ArrayList;
import java.util.List;

public class Warehouse {
    private String id;
    private String pid;
    private String name;
    private String text;
    private String type;
    private String path;
    private final List<Warehouse> children = new ArrayList<>();

    public static List<Warehouse> build(List<Warehouse> list, String topId) {
        List<Warehouse> n1 = new ArrayList<>();

        for (Warehouse f1 : list) {
            if (f1.getPid().equals(topId)) {
                n1.add(recursion(f1, list));
            }

        }
        return n1;
    }

    private static Warehouse recursion(Warehouse warehouse, List<Warehouse> list) {
        for (Warehouse w : list) {
            if (warehouse.getId().equals(w.getPid())) {
                warehouse.getChildren().add(w);
                recursion(w, list);
            }
        }
        return warehouse;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Warehouse> getChildren() {
        return children;
    }
}
