package uqac.aop.chess;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.Board;


public aspect test {

    private int counter = 0;

    pointcut callDemoAspectPointCut():
            execution(* edu.uqac.aop.chess.agent.HumanPlayer.makeMove());

    after() returning(Object r) : callDemoAspectPointCut() {

        System.out.println("Return value: " + r.toString()); // getting return value

        try {
            FileWriter fw = new FileWriter("test", true);
            BufferedWriter bw = new BufferedWriter(fw);

            if (this.counter == 0) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                LocalDateTime now = LocalDateTime.now();
                //System.out.println(dtf.format(now));
                bw.write("\n====================================\n====================================\n\n");
                bw.newLine();
                bw.write(dtf.format(now));
                bw.newLine();
            }
            bw.write(r.toString());
            bw.newLine();
            bw.close();
            this.counter += 1;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

aspect test2 {

    private Piece startingPiece;
    private Piece endingPiece;
    private Board playground;


    pointcut callDemoAspectPointCut(Move mv, Board playground):
            (call(boolean edu.uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, playground));

    private void checkIsLegal(Piece piece, Move mv) {
        if (!piece.isMoveLegal(mv)) {
            System.out.println("Move illegal");
            mv.canMove = false;
        }
        else {
            System.out.println("legal move");
        }
    }

    private void isPlayerPieceHit(Move mv) {
        if (this.startingPiece.getPlayer() == this.endingPiece.getPlayer()) {
            System.out.println(this.startingPiece.getPlayer());
            System.out.println(this.endingPiece.getPlayer());
            System.out.println("pièce au même joueur");
            mv.canMove = false;
        } else {
            System.out.println("test");
            mv.canMove = true;
            //errorDetected = false;
        }
    }

    private void isPlayerPiece(Move mv) {
        if (this.startingPiece.getPlayer() == 0) {
            System.out.println("Cette pièce t'appartient pas");
            mv.canMove = false;
        }
    }

    private void checkInBoard(Move mv) {
        if (mv.xF < 0 || mv.yF > 7) {
            System.out.println("Ce coup sort de l'échéquier");
            mv.canMove = false;
        }
    }

    boolean around(Move mv, Board bd): callDemoAspectPointCut(mv, bd) {
        this.playground = bd;
        boolean result = false;

        if (mv == null) {
            System.out.println("Impossible de réaliser ce déplacement.");
        }
        checkInBoard(mv);
        if (playground.getGrid()[mv.xI][mv.yI].isOccupied()) {
            this.startingPiece = playground.getGrid()[mv.xI][mv.yI].getPiece();
            System.out.println(this.startingPiece.getPlayer());
            isPlayerPiece(mv);
            if (playground.getGrid()[mv.xF][mv.yF].isOccupied()) {
                this.endingPiece = playground.getGrid()[mv.xF][mv.yF].getPiece();
                isPlayerPieceHit(mv);
            }
            checkIsLegal(this.startingPiece, mv);
            if (mv.canMove) {
                // Implémenter ici la fonction de gestion du non saut des pièces
            }
        }
        else {
            System.out.println("Case vide, impossible de jouer ce coup");
            mv.canMove = false;
        }
        if (!mv.canMove)
            mv = null;
        result = proceed(mv, bd);

        return result;
    }
}