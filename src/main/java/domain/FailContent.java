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
    private String text;
    private String classification;
    private String defect_name;
    private final List<FailContent> children = new ArrayList<>();

    public static List<FailContent> build(List<FailContent> list, Integer topId) {
        List<FailContent> n1 = new ArrayList<>();

        for (FailContent f1 : list) {
            if (f1.getPid().equals(topId)) {
                f1.setText(f1.getClassification());
                n1.add(f1);
            }

            for (FailContent f2 : list) {
                if (f2.getPid().equals(f1.getId())) {
                    f2.setText(f2.getDefect_name());
                    f1.getChildren().add(f2);
                }
            }
        }
        return n1;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<FailContent> getChildren() {
        return children;
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
