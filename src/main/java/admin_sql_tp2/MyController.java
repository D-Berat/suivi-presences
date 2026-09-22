package admin_sql_tp2;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import java.sql.SQLException;
public class MyController {

    @FXML private Button myConnexionButton;
    @FXML private Label myConnexionLabel;
    @FXML private TextField myIdentityTextField;
    @FXML private TextField myPasswordTextField;

    // Interface Consultation (Lecture)
    @FXML private TextField textFieldIdGroupe;
    @FXML private Label labelResultatLecture;

    // Interface Saisie (Écriture)
    @FXML private TextField textFieldIdSeance;
    @FXML private TextField textFieldIdEtudiant;
    @FXML private TextField textFieldStatut;
    @FXML private Label labelResultatEcriture;

    // MSSQL
    private MyJDBC myJDBC = new MyJDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver",
            "jdbc:sqlserver://localhost:1433;instanceName=SQLEXPRESS;databaseName=SAE_2_04;trustServerCertificate=true");
               //"jdbc:sqlserver://172.30.4.243\\LHAMON;databaseName=testaccountDB");

    // MYSQL
    //private MyJDBC myJDBC=new MyJDBC("com.mysql.cj.jdbc.Driver",
    //           "jdbc:mysql://localhost:3306/live");

    private boolean connected=false;

    @FXML
    void connexionPressEvent(ActionEvent event)
            throws ClassNotFoundException, SQLException {
            if(!connected){
                myJDBC.connect( myIdentityTextField.getText(),
                                myPasswordTextField.getText());
                myConnexionLabel.setText("Connecté");
                connected=true;
            }
            else{
                myJDBC.disconnect();
                myConnexionLabel.setText("Pas connecté");
                connected=false;
            }
    }

    @FXML
    void afficherEtudiantsEvent(ActionEvent event) throws SQLException {
        String idGroupe = textFieldIdGroupe.getText();
        String query = "SELECT E.ine_etudiant, E.nom_etudiant, E.prenom_etudiant " +
                "FROM dbo.ETUDIANT E " +
                "INNER JOIN dbo.APPARTENIR A ON E.ine_etudiant = A.ine_etudiant " +
                "WHERE A.id_groupe = '" + idGroupe + "'";

        String result = myJDBC.executeReadQuery(query);
        labelResultatLecture.setText(result);
    }

    @FXML
    void enregistrerPresenceEvent(ActionEvent event) throws SQLException {
        String idSeance = textFieldIdSeance.getText();
        String idEtudiant = textFieldIdEtudiant.getText();
        String statut = textFieldStatut.getText();

        String query = "DECLARE @gr VARCHAR(50) = (SELECT id_groupe FROM dbo.SEANCE WHERE id_seance = '" + idSeance + "'); "
                + "IF EXISTS (SELECT 1 FROM dbo.PRESENCE WHERE id_seance = '" + idSeance + "' AND ine_etudiant = '" + idEtudiant + "') "
                + "UPDATE dbo.PRESENCE SET etat_presence = '" + statut + "' WHERE id_seance = '" + idSeance + "' AND ine_etudiant = '" + idEtudiant + "'; "
                + "ELSE "
                + "INSERT INTO dbo.PRESENCE (id_groupe, ine_etudiant, id_seance, etat_presence) VALUES (@gr, '" + idEtudiant + "', '" + idSeance + "', '" + statut + "');";

        String result = myJDBC.executeWriteQuery(query);
        labelResultatEcriture.setText(result);
    }

}
