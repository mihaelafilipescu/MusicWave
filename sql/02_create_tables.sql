--------------------------------------------------------- GEN -------------------------------------------------------------------------
CREATE TABLE GEN
(
    ID_GEN   NUMBER PRIMARY KEY,
    NUME_GEN VARCHAR2(50) NOT NULL
);
CREATE SEQUENCE SEQ_GEN
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- PRODUCATOR -------------------------------------------------------------------------
CREATE TABLE PRODUCATOR
(
    ID_PRODUCATOR NUMBER PRIMARY KEY,
    NUME          VARCHAR2(100) NOT NULL,
    TARA          VARCHAR2(50)
);
CREATE SEQUENCE SEQ_PRODUCATOR
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- ADRESA -------------------------------------------------------------------------
CREATE TABLE ADRESA
(
    ID_ADRESA  NUMBER PRIMARY KEY,
    TARA       VARCHAR2(50),
    ORAS       VARCHAR2(50),
    STRADA     VARCHAR2(50),
    NUMAR      NUMBER,
    COD_POSTAL NUMBER
);
CREATE SEQUENCE SEQ_ADRESA
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- UTILIZATOR -------------------------------------------------------------------------
CREATE TABLE UTILIZATOR
(
    ID_UTILIZATOR     NUMBER PRIMARY KEY,
    NUME              VARCHAR2(50)         NOT NULL,
    PRENUME           VARCHAR2(50)         NOT NULL,
    EMAIL             VARCHAR2(50) UNIQUE NOT NULL,
    PAROLA            VARCHAR2(50)        NOT NULL,
    NUMAR_DE_TELEFON  VARCHAR(12),
    DATA_INREGISTRARE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_UTILIZATOR
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- CUPON -------------------------------------------------------------------------
CREATE TABLE CUPON
(
    ID_CUPON      NUMBER PRIMARY KEY,
    VALOARE       NUMBER CHECK (VALOARE > 0),
    DATA_INCEPUT  DATE,
    DATA_EXPIRARE DATE
);
CREATE SEQUENCE SEQ_CUPON
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- ARTIST -------------------------------------------------------------------------
CREATE TABLE ARTIST
(
    ID_ARTIST NUMBER PRIMARY KEY,
    NUME      VARCHAR2(100) NOT NULL
);
CREATE SEQUENCE SEQ_ARTIST
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- ALBUM -------------------------------------------------------------------------
CREATE TABLE ALBUM
(
    ID_ALBUM   NUMBER PRIMARY KEY,
    TITLU      VARCHAR2(100) NOT NULL,
    AN_LANSARE NUMBER(4),
    ID_ARTIST  NUMBER        NOT NULL,
    PRET NUMBER CHECK (PRET >= 0),
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST (ID_ARTIST)
);
CREATE SEQUENCE SEQ_ALBUM
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- PIESA -------------------------------------------------------------------------
CREATE TABLE PIESA
(
    ID_PIESA NUMBER PRIMARY KEY,
    TITLU    VARCHAR2(50),
    ID_ARTIST NUMBER NOT NULL,
    ID_GEN NUMBER,
    DURATA NUMBER CHECK (DURATA > 0),
    DATA_LANSARII DATE,
    PRET NUMBER CHECK (PRET > 0),
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST(ID_ARTIST),
    FOREIGN KEY (ID_GEN) REFERENCES GEN(ID_GEN)
);
CREATE SEQUENCE SEQ_PIESA
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- COMANDA -------------------------------------------------------------------------
CREATE TABLE COMANDA
(
    ID_COMANDA    NUMBER PRIMARY KEY,
    ID_UTILIZATOR NUMBER NOT NULL,
    DATA_COMANDA  DATE         DEFAULT SYSDATE,
    STATUS        VARCHAR2(30) DEFAULT 'în așteptare',
    FOREIGN KEY (ID_UTILIZATOR) REFERENCES UTILIZATOR (ID_UTILIZATOR)
);
CREATE SEQUENCE SEQ_COMANDA
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- PLAYLIST -------------------------------------------------------------------------
CREATE TABLE PLAYLIST
(
    ID_PLAYLIST   NUMBER PRIMARY KEY,
    TITLU         VARCHAR2(50),
    NUMAR_PIESE   NUMBER CHECK (NUMAR_PIESE > 0),
    DURATA_TOTALA NUMBER(4) CHECK(DURATA_TOTALA > 0)
);
CREATE SEQUENCE SEQ_PLAYLIST
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100;
--------------------------------------------------------- RECENZIE -------------------------------------------------------------------------
CREATE TABLE RECENZIE
(
    ID_UTILIZATOR NUMBER,
    ID_PIESA      NUMBER,
    SCOR          NUMBER(2) CHECK (SCOR BETWEEN 0 AND 11),
    COMENTARIU    VARCHAR2(1000),
    DATA_RECENZIE DATE,
    PRIMARY KEY (ID_UTILIZATOR, ID_PIESA),
    FOREIGN KEY (ID_UTILIZATOR) REFERENCES UTILIZATOR (ID_UTILIZATOR),
    FOREIGN KEY (ID_PIESA) REFERENCES PIESA (ID_PIESA)
);
--------------------------------------------------------- ARTIST_SOLO -------------------------------------------------------------------------
CREATE TABLE ARTIST_SOLO
(
    ID_ARTIST NUMBER PRIMARY KEY,
    TARA_ORIGINE VARCHAR2(50),
    DATA_DEBUTULUI DATE,
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST(ID_ARTIST)
);
--------------------------------------------------------- TRUPA -------------------------------------------------------------------------
CREATE TABLE TRUPA
(
    ID_ARTIST NUMBER PRIMARY KEY,
    ANUL_INFIINTARII DATE,
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST(ID_ARTIST)
);
--------------------------------------------------------- PIESA_INDIVIDUALA -------------------------------------------------------------------------
CREATE TABLE PIESA_INDIVIDUALA
(
    ID_PIESA NUMBER PRIMARY KEY,
    ID_PRODUCATOR NUMBER,
    FOREIGN KEY (ID_PRODUCATOR) REFERENCES PRODUCATOR(ID_PRODUCATOR),
    FOREIGN KEY (ID_PIESA) REFERENCES PIESA(ID_PIESA)
);
--------------------------------------------------------- PIESA_ALBUM -------------------------------------------------------------------------
CREATE TABLE PIESA_ALBUM
(
    ID_PIESA NUMBER PRIMARY KEY,
    ID_ALBUM NUMBER,
    NUMAR_POZITIE NUMBER,
    FOREIGN KEY (ID_PIESA) REFERENCES PIESA(ID_PIESA),
    FOREIGN KEY (ID_ALBUM) REFERENCES ALBUM(ID_ALBUM)
);
--------------------------------------------------------- CREARE PLAYLIST -------------------------------------------------------------------------
CREATE TABLE CREARE_PLAYLIST
(
    ID_UTILIZATOR NUMBER,
    ID_PLAYLIST   NUMBER,
    PRIMARY KEY (ID_UTILIZATOR, ID_PLAYLIST),
    FOREIGN KEY (ID_PLAYLIST) REFERENCES PLAYLIST (ID_PLAYLIST),
    FOREIGN KEY (ID_UTILIZATOR) REFERENCES UTILIZATOR (ID_UTILIZATOR)
);
--------------------------------------------------------- FOLOSIRE ADRESE -------------------------------------------------------------------------
CREATE TABLE FOLOSIRE_ADRESE
(
    ID_UTILIZATOR NUMBER,
    ID_ADRESA     NUMBER,
    PRIMARY KEY (ID_UTILIZATOR, ID_ADRESA),
    FOREIGN KEY (ID_ADRESA) REFERENCES ADRESA (ID_ADRESA),
    FOREIGN KEY (ID_UTILIZATOR) REFERENCES UTILIZATOR (ID_UTILIZATOR)
);
--------------------------------------------------------- COLABORARE -------------------------------------------------------------------------
CREATE TABLE COLABORARE
(
    ID_ARTIST     NUMBER,
    ID_ALBUM      NUMBER,
    ID_PRODUCATOR NUMBER,
    DATA_COLABORARII DATE,
    PRIMARY KEY (ID_ARTIST, ID_ALBUM, ID_PRODUCATOR),
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST (ID_ARTIST),
    FOREIGN KEY (ID_ALBUM) REFERENCES ALBUM (ID_ALBUM),
    FOREIGN KEY (ID_PRODUCATOR) REFERENCES PRODUCATOR (ID_PRODUCATOR)
);
--------------------------------------------------------- INREGISTRARE -------------------------------------------------------------------------
CREATE TABLE INREGISTRARE
(
    ID_ARTIST NUMBER,
    ID_PIESA  NUMBER,
    PRIMARY KEY (ID_PIESA, ID_ARTIST),
    FOREIGN KEY (ID_ARTIST) REFERENCES ARTIST(ID_ARTIST),
    FOREIGN KEY (ID_PIESA) REFERENCES PIESA(ID_PIESA)
);


