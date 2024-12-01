

/*
 * Palette Graphique - prélude au projet multimodal 3A SRI
 * 4 objets gérés : cercle, rectangle(carré), losange et triangle
 * (c) 05/11/2019
 * Dernière révision : 28/04/2020
 */
 
import java.awt.Point;
import fr.dgac.ivy.*;
import java.util.*;
Ivy bus;
Ivy bus2;
ArrayList<Forme> formes; // liste de formes stockées
FSM mae; // Finite Sate Machine
int indice_forme;
PImage sketch_icon;
PImage img;
String action_val="";
String where_val="";
String form_val="";
String color_val="";
String localisation_val="";
String Template_val="";
int i_form_select = 0;
int clic =0;
Point loc = new Point(0,0);
Commande commande = new Commande("","","","","");
int i=0;
void setup() {
  try {
   bus = new Ivy("audio", "audio is ready", null);
    bus.start("127.255.255.255:2010");
  }catch (IvyException ie) {
        }
  try {
     bus2 = new Ivy("ecrit", "ecrit is ready", null);
      bus2.start("127.255.255.255:2010");
    }catch (IvyException ie) {
          }
  background(0);
  action_val="";
 where_val="";
form_val="";
 color_val="";
 localisation_val="";
 Template_val="";

  size(800,600);
  surface.setResizable(true);
  surface.setTitle("Palette multimodale");
  surface.setLocation(20,20);
  sketch_icon = loadImage("Palette.jpg");
  surface.setIcon(sketch_icon);
  
  formes= new ArrayList(); // nous créons une liste vide
  noStroke();
  mae = FSM.INITIAL;
  i_form_select = -1;
}

void draw() {
  
  //println("MAE : " + mae + " indice forme active ; " + indice_forme);
   try {
          
         
          
           bus.bindMsg("^sra5 Parsed=(.*)=(.*) (.*)=(.*) (.*)=(.*) (.*)=(.*) (.*)=(.*) Confidence=(.*) NP=.*", new IvyMessageListener() {
            // dans args[0] --> action
            // dans args[1] --> action_val (CREATE,MOVE, ...)
            
            // dans args[2] --> where
            // dans args[3] --> where_val
            // dans args[4] --> from
            // dans args[5] --> form_val
            // dans args[6] --> color
            // dans args[7] --> color_val
            // dans args[8] --> localisation
            // dans args[9] --> localisation_val
                      
            // dans args[10] --> le taux de confiance
            
            public void receive(IvyClient client,String[] args) {
              
              // attention : on reçoit des 0,xx et on ne peut traiter que des 0.xx
              if (Float.parseFloat(args[10].replace(",",".")) > 0.5) {
                for(int arg=0;arg<11;arg++){
                  println(args[arg]);
               }
              action_val = args[1];
              where_val = args[3];
              form_val = args[5];
              color_val = args[7];
              localisation_val = args[9];
              //}
              }
              
             
              
              else { // reco trop faible
                // feedback vocal
                try {
                  bus.sendMsg("ppilot5 Say=Je n'ai pas bien compris, pouvez-vous répéter s'il vous plaît");
                }
                catch (IvyException ie) {}   
              }
            }
          });
          
          bus.bindMsg("^sra5 Event=Speech_Rejected", new IvyMessageListener() {
            public void receive(IvyClient client,String[] args) {
              
              img=null;
            }
          });    
        }
        catch (IvyException ie) {
        }
      
        
//Pour ODI
    try {
          
          
          bus2.bindMsg("^OneDollarIvy (.*)=(.*) Confidence=(.*)", new IvyMessageListener() {
            // dans args[1] --> forme
     
                      
            // dans args[2] --> le taux de confiance
            
            public void receive(IvyClient client,String[] args2) {
              Template_val = args2[1];
              form_val = args2[1];
              //println(Template_val);
              // attention : on reçoit des 0,xx et on ne peut traiter que des 0.xx
              if (Float.parseFloat(args2[2].replace(",",".")) > 0.6) {
                //for(int arg=0;arg<11;arg++){
                 // println("Confidence",args[2]);
                  
                }
              
              
             
              
              else { // reco trop faible
                // feedback vocal
                try {
                  bus2.sendMsg("ppilot5 Say=Je n'ai pas bien compris, pouvez-vous répéter s'il vous plaît");
                }
                catch (IvyException ie) {}   
              }
            }
          });
            
        }
        catch (IvyException ie) {
        }
            commande.setAction(action_val);
            commande.setForm(form_val);
            commande.setCol(color_val);
            commande.setWhere(where_val);
            commande.setLoca(localisation_val);
  switch (mae) {
    case INITIAL:  // Etat INITIAL
            background(255);
            fill(0);
            
           if(action_val.equals("CREATE"))
           {
           mae=FSM.AFFICHER_FORMES;
           println("Action create envoyee");
             break;
           }else if(action_val.equals("MOVE") && !where_val.equals("undefined"))
           { mae=FSM.DEPLACER_FORMES_SELECTION;
           println("Action move envoyee");
             break;
           }
           
              
      break;
      
    case AFFICHER_FORMES:
    println("AFFICHER FORMES");
    //if (form_val.equals("CIRCLE")) {
    // commande.setForm("CIRCLE"); println("circleSet");
    //}else if(form_val.equals("RECTANGLE")){
    // commande.setForm("RECTANGLE"); 
    //}else if(form_val.equals("DIAMOND")){
    // commande.setForm("DIAMOND"); 
    //}else if(form_val.equals("TRIANGLE")){
    // commande.setForm("TRIANGLE"); 
    //}else {
    // commande.setForm(""); 
    //}
    
    //if (action_val.equals("CREATE")) {
    // commande.setAction("CREATE"); 
    //}else if(action_val.equals("DELETE")){
    // commande.setAction("DELETE"); 
    //}else if(action_val.equals("QUIT")){
    // commande.setAction("QUIT"); 
    //}else if(action_val.equals("MOVE")){
    // commande.setAction("MOVE"); 
    //}else {
    // commande.setAction(""); 
    //}
    println("NOMBRE FORMES=",formes.size());
    
    

// Vérifier si l'action est un déplacement
if (action_val.equals("MOVE") && !where_val.equals("undefined")) {
    mae = FSM.DEPLACER_FORMES_SELECTION; // Passer à l'état de déplacement
    println("Action MOVE envoyée");
    break;
}

if (action_val.equals("DELETE")) {
    mae = FSM.INITIAL; // Passer à l'état de déplacement
    background(255);
    formes= new ArrayList<Forme>();
    break;
}
    
    
    //if (localisation_val.equals("THERE")) {
    // commande.setLoca("THERE"); 
    //}else {
    // commande.setLoca(""); 
    //}
    
    
    
    //if (color_val.equals("RED")) {
    // commande.setCol("RED"); 
    //}
    //else if (color_val.equals("ORANGE")) {
    // commande.setCol("ORANGE"); 
    //}
    //else if (color_val.equals("YELLOW")) {
    // commande.setCol("YELLOW"); 
    //}
    //else if (color_val.equals("GRREN")) {
    // commande.setCol("GRREN"); 
    //}
    //else if (color_val.equals("BLUE")) {
    // commande.setCol("BLUE"); 
    //}
    //else if (color_val.equals("PURPLE")) {
    // commande.setCol("PURPLE"); 
    //}
    
    //else if (color_val.equals("DARK")) {
    // commande.setCol("DARK"); 
     
    //}else {
    // commande.setCol(""); 
    //}
    
    
    
    
    
    
    //commande.clear();
    
    
    
      //if (form_val.equals("CIRCLE")) {
        
      //  if(localisation_val .equals("THERE")){
         
      //   Point point = new Point(400,300);
      //   Cercle circle = new Cercle(point);
      //   circle.setColor(color(random(0,255),random(0,255),random(0,255)));
      //   circle.update();
      //}
      //else {
      //  //TODO create on mouse
      //}
      //}
      //else if (form_val.equals("RECTANGLE")) {
        
      //  if(localisation_val .equals("THERE")){
         
      //   Point point = new Point(400,300);
      //   Rectangle rect = new Rectangle(point);
      //   rect.setColor(color(random(0,255),random(0,255),random(0,255)));
      //   rect.update();
      //}
      //else {
      //  //TODO create on mouse
      //}
      //}
      
        
      break;
      
    case DEPLACER_FORMES_SELECTION: 
    println("DEPLACER FORMES SELECTION");
        //println(Template_val);
        //println(Template_val.contains("rectangle"));
        //if(Template_val.contains("rectangle")) form_val = "RECTANGLE";
        //else if(Template_val.contains("triangle")) form_val = "TRIANGLE";
        //else if(Template_val.contains("cercle")) form_val = "CIRCLE";
        //else form_val = "";
        //println("FORME+++++=",form_val);
        //println("ON Y EST ============================================================");

        break;
          
          
    case DEPLACER_FORMES_DESTINATION: 
    println("DEPLACER FORMES DESTINATION");
    //println("FINALFINAL_______________________________________________________________");
    
     break;  
      
    default:
      break;
  }  

  
}

// fonction d'affichage des formes m
void affiche() {
  background(255);
  /* afficher tous les objets */
  for (int i=0;i<formes.size();i++) // on affiche les objets de la liste
    (formes.get(i)).update();
}

void mousePressed() { // sur l'événement clic
  Point p = new Point(mouseX,mouseY);
  
  switch (mae) {
    case AFFICHER_FORMES:
        //println("FOOOOOOOOOORMES",formes);
        //println(form_val);
        if (where_val.equals("THIS") && action_val.equals("CREATE") && !form_val.equals("")) {
        // Identifier le type de forme à créer à partir du Template_val
        if (Template_val.contains("rectangle")) form_val = "RECTANGLE";
        else if (Template_val.contains("triangle")) form_val = "TRIANGLE";
        else if (Template_val.contains("cercle")) form_val = "CIRCLE";
        else form_val = ""; // Pas de forme valide
        
    
        if (!form_val.equals("")) { // Si un type de forme est défini
            commande.setForm(form_val); // Configurer la commande avec la forme
    
            // Tenter de créer la forme via commander()
            Forme forme = commande.commander();
            if (forme != null) { // Si une forme valide est créée
                if (!formes.contains(forme)) { // Vérifier si elle est déjà dans la liste
                    formes.add(forme); // Ajouter à la liste
                    println("Forme créée et ajoutée : " + forme);
                } else {
                    println("La forme existe déjà dans la liste.");
                }
            } else {
                println("La commande n'a pas produit de forme valide.");
            }
    
            // Afficher les formes et réinitialiser la commande
            affiche();
            commande.clear();
            // Réinitialiser les valeurs pour éviter les duplications
            break;
        }
    } else if (!form_val.equals("undefined")) { // Si form_val est défini mais non lié à "THIS"
    
        // Tenter de créer une forme
        Forme forme = commande.commander();
        commande.clear(); // Nettoyer la commande après son utilisation
    
        if (forme != null && !formes.contains(forme)) { // Ajouter uniquement si elle est unique
            formes.add(forme);
            println("Forme créée et ajoutée : " + forme);
        } else {
            println("La commande n'a pas produit de forme valide ou forme déjà existante.");
        }
    
        affiche(); // Afficher les formes mises à jour
        break;
    }
      //for (int i=0;i<formes.size();i++) { // we're trying every object in the list
         //(formes.get(i)).update();
        //if ((formes.get(i)).isClicked(p)) {
          //(formes.get(i)).setColor(color(random(0,255),random(0,255),random(0,255)));
           
        //}
       
      break;
      
    case DEPLACER_FORMES_SELECTION:
    
     for (int i=0;i<formes.size();i++) { // we're trying every object in the list        
        if ((formes.get(i)).isClicked(p)) {
          i_form_select = i;
          clic = 1;
          //println(i_form_select);
          mae = FSM.DEPLACER_FORMES_DESTINATION;
        }         
     }
     if (i_form_select == -1){
       mae= FSM.AFFICHER_FORMES;
     }       
     break;
     
   case DEPLACER_FORMES_DESTINATION:
     
     if (i_form_select !=-1){
    
       (formes.get(i_form_select)).setLocation(new Point(mouseX,mouseY));
     i_form_select =-1;
     clic = 2;
     affiche();
     mae = FSM.AFFICHER_FORMES;
     action_val="";
     }
     
     

     break;
     
    default:
      break;
  }
}


void keyPressed() {
  Point p = new Point(mouseX,mouseY);
  //switch(key) {
  //  case 'r':
  //    Forme f= new Rectangle(p);
  //    formes.add(f);
  //    mae=FSM.AFFICHER_FORMES;
  //    break;
      
  //  case 'c':
  //    Forme f2=new Cercle(p);
  //    formes.add(f2);
  //    mae=FSM.AFFICHER_FORMES;
  //    break;
    
  //  case 't':
  //    Forme f3=new Triangle(p);
  //    formes.add(f3);
  //     mae=FSM.AFFICHER_FORMES;
  //    break;  
      
  //  case 'l':
  //    Forme f4=new Losange(p);
  //    formes.add(f4);
  //    mae=FSM.AFFICHER_FORMES;
  //    break;    
      
  //  case 'm' : // move
  //    mae=FSM.DEPLACER_FORMES_SELECTION;
  //    break;
  //}
}
