package domain;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author:
 * @createDate: 2022/5/9
 */
public class FailContent {
    private Integer id;
    private Integer pid;
    private String classification;
    private String defect_name;
    private final List<FailContent> child = new ArrayList<>();

    public static List<FailContent> build(List<FailContent> list, Integer topId) {
        List<FailContent> n1 = new ArrayList<>();

        for (FailContent f1 : list) {
            if (f1.getPid().equals(topId)) {
                n1.add(f1);
            }

            for (FailContent f2 : list) {
                if (f2.getPid().equals(f1.getId())) {
                    f1.getChild().add(f2);
                }
            }
        }
        return n1;
    }

    public List<FailContent> getChild() {
        return child;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getDefect_name() {
        return defect_name;
    }

    public void setDefect_name(String defect_name) {
        this.defect_name = defect_name;
    }
}
