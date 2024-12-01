/*
 * Classe Cercle
 */ 
 import java.awt.Color;
public class Commande {
  
  private String action;
  private String where;
  private String form;
  private String col;
  private String loca;
  
  private Forme true_form;
  
  public Commande(String action, String where, String form, String col, String loca) {
    this.action = action;
    this.where = where;
    this.form = form;
    this.col = col;
    this.loca = loca;
    this.true_form = null;
    
    
    
    
  }
  
  // Getters
  public String getAction() {
    return action;
  }

  public String getWhere() {
    return where;
  }

  public String getForm() {
    return form;
  }

  public String getCol() {
    return col;
  }

  public String getLoca() {
    return loca;
  }
  
  // Setters
  public void setAction(String action) {
    this.action = action;
  }

  public void setWhere(String where) {
    this.where = where;
  }

  public void setForm(String form) {
    this.form = form;
  }

  public void setCol(String col) {
    this.col = col;
  }

  public void setLoca(String loca) {
    this.loca = loca;
  }

  public void clear() {
    this.action = "";
    this.where = "";
    this.form = "";
    this.col = "";
    this.loca = "";
  }  
  
  
  public Forme commander() {
    
    Point p = new Point(100, 100);
    
    // Mise à jour de la position en fonction de `where` et `loca`
    
    // Création de l'objet en fonction de `form`
    if (this.form.equals("CIRCLE")) {
        this.true_form = new Cercle(p);
    } else if (this.form.equals("DIAMOND")) {
        this.true_form = new Losange(p);
    } else if (this.form.equals("TRIANGLE")) {
        this.true_form = new Triangle(p);
    } else if (this.form.equals("RECTANGLE")) {
        this.true_form = new Rectangle(p);
    } else {
        System.out.println("no input for form");
        
          // Arrêter si la forme n'est pas valide
    }
    //println("FORME=",this.form);
    //if (this.where.equals("THIS")) {
    //  p.setLocation(new Point(mouseX, mouseY));  // On suppose que `mouseX` et `mouseY` sont disponibles dans le contexte
    //} else 
    if (this.loca.equals("THERE")) {
      this.true_form.setLocation(new Point(mouseX, mouseY));
    }
    
    color c;
    
    if (this.col.equals("RED")) {
        c = color(255,0,0);
        int colorval = c;
        this.true_form.setColor(colorval);
    } else if (this.col.equals("GREEN")) {
        c = color(0,255,0);
        int colorval = c;
        this.true_form.setColor(colorval);
    } else if (this.col.equals("BLUE")) {
        c = color(0,0,255);
        int colorval = c;
        this.true_form.setColor(colorval);
    } else if (this.col.equals("YELLOW")) {
        c = color(255,255,0);
        int colorval = c;
        this.true_form.setColor(colorval);  
    } else if (this.col.equals("DARK")) {
        c = color(0,0,0);
        int colorval = c;
        this.true_form.setColor(colorval);
    }else if (this.col.equals("ORANGE")) {
        c = color(255,165,0);
        int colorval = c;
        this.true_form.setColor(colorval);
    }else if (this.col.equals("PURPLE")) {
        c = color(128,0,128);
        int colorval = c;
        this.true_form.setColor(colorval);
    }
    else {
        System.out.println("no input for color");
    }
    //println("COLOR=",this.col);
    
    Forme f = this.true_form;
    
    this.clear();
    
    return f;
}
    
}
