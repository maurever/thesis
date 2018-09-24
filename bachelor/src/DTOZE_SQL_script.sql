/* Smazani tabulek pokud existuji. */
DROP TABLE DTOZE_Application ;
DROP TABLE DTOZE_Category ;
DROP TABLE DTOZE_Company ;
DROP TABLE DTOZE_Change ;
DROP TABLE DTOZE_Orientation ;
DROP TABLE DTOZE_Parameter ;
DROP TABLE DTOZE_Place ;
DROP TABLE DTOZE_PlaceType ;
DROP TABLE DTOZE_Product ;
DROP TABLE DTOZE_Statement ;
DROP TABLE DTOZE_StatementType ;
DROP TABLE DTOZE_StatementValue ;
DROP TABLE DTOZE_SurveyItem ;
DROP TABLE DTOZE_Technology ;
DROP TABLE DTOZE_TechnologyType ;
DROP TABLE DTOZE_Unit ;
DROP TABLE DTOZE_User ;

/* Smazani sekvenci pokud existuji. */
DROP SEQUENCE DTOZE_Application_id_seq;
DROP SEQUENCE DTOZE_Category_id_seq;
DROP SEQUENCE DTOZE_Company_id_seq;
DROP SEQUENCE DTOZE_Change_id_seq;
DROP SEQUENCE DTOZE_Orientation_id_seq;
DROP SEQUENCE DTOZE_Parameter_id_seq;
DROP SEQUENCE DTOZE_Place_id_seq;
DROP SEQUENCE DTOZE_PlaceType_id_seq;
DROP SEQUENCE DTOZE_Product_id_seq;
DROP SEQUENCE DTOZE_Statement_id_seq;
DROP SEQUENCE DTOZE_StatementType_id_seq;
DROP SEQUENCE DTOZE_StatementValue_idProduct_seq;
DROP SEQUENCE DTOZE_Technology_id_seq;
DROP SEQUENCE DTOZE_TechnologyType_id_seq;
DROP SEQUENCE DTOZE_Unit_id_seq;
DROP SEQUENCE DTOZE_User_id_seq;

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Application. */
CREATE SEQUENCE DTOZE_Application_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Application. */
CREATE TABLE DTOZE_Application ( 
	id integer DEFAULT nextval('DTOZE_Application_id_seq') NOT NULL,
	name varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	companyName varchar(50) NOT NULL,
	phoneNumber varchar(20) NOT NULL,
	companyWeb text NOT NULL,
	street varchar(20) NOT NULL,
	streetNumber varchar(10) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
  postalCode varchar(10) NOT NULL,
	datePosting timestamp NOT NULL,
	dateConfirmation timestamp,
	idAdmin integer
);

/* Vytvoreni omezeni pro tabulku DTOZE_Application.*/
ALTER TABLE DTOZE_Application 
  ADD CONSTRAINT PK_Application PRIMARY KEY (id);

ALTER TABLE DTOZE_Application
	ADD CONSTRAINT UQ_Application_companyWeb UNIQUE (companyWeb);
  
ALTER TABLE DTOZE_Application
	ADD CONSTRAINT UQ_Application_email UNIQUE (email);
  
ALTER TABLE DTOZE_Application
	ADD CONSTRAINT UQ_Application_id UNIQUE (id);
  
ALTER TABLE DTOZE_Application
  ADD CONSTRAINT valide_email CHECK (email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,6}$');

ALTER TABLE DTOZE_Application
  ADD CONSTRAINT valide_phone CHECK (phonenumber ~ '^\+?[0-9]{3}-?[0-9](-[0-9]+)+$');  

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Category. */

CREATE SEQUENCE DTOZE_Category_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Category */
CREATE TABLE DTOZE_Category ( 
	id integer DEFAULT nextval('DTOZE_Category_id_seq') NOT NULL,
	name varchar(50) NOT NULL,
	information text
);

/* Vytvoreni omezeni pro tabulku DTOZE_Category.*/
ALTER TABLE DTOZE_Category 
  ADD CONSTRAINT PK_Category PRIMARY KEY (id);

ALTER TABLE DTOZE_Category
	ADD CONSTRAINT UQ_Category_id UNIQUE (id);
  
ALTER TABLE DTOZE_Category
	ADD CONSTRAINT UQ_Category_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Change. */
CREATE SEQUENCE DTOZE_Change_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Change */
CREATE TABLE DTOZE_Change ( 
	id integer DEFAULT nextval('DTOZE_Change_id_seq') NOT NULL,
	subject varchar(50) NOT NULL,
	information text NOT NULL,
	newValue varchar(30) NOT NULL,
	status varchar(4) NOT NULL,
	adminMessage text,
  datePosting timestamp NOT NULL,
	dateConfirmation timestamp,
	idUserSend integer NOT NULL,
	idUserConfirmed integer,
	idProduct integer NOT NULL,
	idStatement integer
);

/* Vytvoreni omezeni pro tabulku DTOZE_Change.*/
ALTER TABLE DTOZE_Change 
  ADD CONSTRAINT PK_Change PRIMARY KEY (id);

ALTER TABLE DTOZE_Change
	ADD CONSTRAINT UQ_Change_id UNIQUE (id);

ALTER TABLE DTOZE_Change
  ADD CONSTRAINT non_empty_message CHECK (adminMessage <> '');

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Company. */
CREATE SEQUENCE DTOZE_Company_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_ */
CREATE TABLE DTOZE_Company ( 
	id integer DEFAULT nextval('DTOZE_Company_id_seq') NOT NULL,
	companyName varchar(50) NOT NULL,
	webpage text NOT NULL,
	phoneNumber varchar(20) NOT NULL,
	street varchar(20) NOT NULL,
	streetNumber varchar(10) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	postalCode varchar(10) NOT NULL,
	numberViews integer DEFAULT 0 NOT NULL,
	countProduct integer DEFAULT 0 NOT NULL,
	idProducent integer
);

/* Vytvoreni omezeni pro tabulku DTOZE_Company.*/
ALTER TABLE DTOZE_Company 
  ADD CONSTRAINT PK_Company PRIMARY KEY (id);

ALTER TABLE DTOZE_Company
	ADD CONSTRAINT UQ_Company_id UNIQUE (id);
  
ALTER TABLE DTOZE_Company
	ADD CONSTRAINT UQ_company_name UNIQUE (companyName);
  
ALTER TABLE DTOZE_Company
	ADD CONSTRAINT UQ_webpage UNIQUE (webpage);
  
ALTER TABLE DTOZE_Company
	ADD CONSTRAINT UQ_idproducent UNIQUE (idProducent);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Orientation. */
CREATE SEQUENCE DTOZE_Orientation_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Orientation */
CREATE TABLE DTOZE_Orientation ( 
	id integer DEFAULT nextval('DTOZE_Orientation_id_seq') NOT NULL,
	shortcut varchar(10) NOT NULL,
	name varchar(50) NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_Orientation.*/
ALTER TABLE DTOZE_Orientation 
  ADD CONSTRAINT PK_Orientation PRIMARY KEY (id);

ALTER TABLE DTOZE_Orientation
	ADD CONSTRAINT UQ_Orientation_id UNIQUE (id);
  
ALTER TABLE DTOZE_Orientation
	ADD CONSTRAINT UQ_Orientation_name UNIQUE (name);
  
ALTER TABLE DTOZE_Orientation
	ADD CONSTRAINT UQ_Orientation_shortcut UNIQUE (shortcut);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Parameter. */
CREATE SEQUENCE DTOZE_Parameter_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Parameter */
CREATE TABLE DTOZE_Parameter ( 
	id integer DEFAULT nextval('DTOZE_Parameter_id_seq') NOT NULL,
	value decimal(4,1) NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_Parameter.*/
ALTER TABLE DTOZE_Parameter 
  ADD CONSTRAINT PK_Parameter PRIMARY KEY (id);

ALTER TABLE DTOZE_Parameter
	ADD CONSTRAINT UQ_Parameter_id UNIQUE (id);
  
ALTER TABLE DTOZE_Parameter
	ADD CONSTRAINT UQ_Parameter_value UNIQUE (value);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Place. */
CREATE SEQUENCE DTOZE_Place_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Place */
CREATE TABLE DTOZE_Place ( 
	id integer DEFAULT nextval('DTOZE_Place_id_seq') NOT NULL,
	name varchar(30) NOT NULL,
	information text
);

/* Vytvoreni omezeni pro tabulku DTOZE_Place.*/
ALTER TABLE DTOZE_Place 
  ADD CONSTRAINT PK_Place PRIMARY KEY (id);

ALTER TABLE DTOZE_Place
	ADD CONSTRAINT UQ_Place_id UNIQUE (id);
  
ALTER TABLE DTOZE_Place
	ADD CONSTRAINT UQ_Place_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_PlaceType. */
CREATE SEQUENCE DTOZE_PlaceType_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_PlaceType */
CREATE TABLE DTOZE_PlaceType ( 
	id integer DEFAULT nextval('DTOZE_PlaceType_id_seq') NOT NULL,
	name varchar(50) NOT NULL,
	information text,
	idPlace integer NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_PlaceType.*/
ALTER TABLE DTOZE_PlaceType 
  ADD CONSTRAINT PK_PlaceType PRIMARY KEY (id);

ALTER TABLE DTOZE_PlaceType
	ADD CONSTRAINT UQ_PlaceType_id UNIQUE (id);
  
ALTER TABLE DTOZE_PlaceType
	ADD CONSTRAINT UQ_PlaceType_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Product. */
CREATE SEQUENCE DTOZE_Product_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Product */
CREATE TABLE DTOZE_Product ( 
	id integer DEFAULT nextval('DTOZE_Product_id_seq') NOT NULL,
	name varchar(50) NOT NULL,
	imageUrl text NOT NULL,
	information text,
	datePosting timestamp NOT NULL,
	dateConfirmation timestamp,
	dateEditing timestamp,
	numberViews integer DEFAULT 0 NOT NULL,
	status varchar(4) NOT NULL,
	adminMessage text,
	idUserPosted integer NOT NULL,
	idUserConfirmed integer,
	idUserEdited integer,
	idCompany integer NOT NULL,
	idTechnology integer NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_Product.*/
ALTER TABLE DTOZE_Product 
  ADD CONSTRAINT PK_Product PRIMARY KEY (id);

ALTER TABLE DTOZE_Product
	ADD CONSTRAINT UQ_Product_id UNIQUE (id);
  
ALTER TABLE DTOZE_Product
	ADD CONSTRAINT UQ_Product_imageUrl UNIQUE (imageUrl);
  
ALTER TABLE DTOZE_Product
	ADD CONSTRAINT UQ_Product_name UNIQUE (name);
  
/* Vytvoreni indexu pro sloupce tabulky DTOZE_Product */
  
CREATE INDEX IX_Product_dateConfirmation
	ON DTOZE_Product (dateConfirmation);
  
CREATE INDEX IX_Product_dateEditing
	ON DTOZE_Product (dateEditing);
  
CREATE INDEX IX_Product_numberViews
	ON DTOZE_Product (numberViews);
  
CREATE INDEX IX_Product_idCompany
	ON DTOZE_Product (idCompany);
  
CREATE INDEX IX_Product_idTechnology
	ON DTOZE_Product (idTechnology);
  
CREATE INDEX IX_Product_name
	ON DTOZE_Product (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Statement. */
CREATE SEQUENCE DTOZE_Statement_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Statement */
CREATE TABLE DTOZE_Statement ( 
	id integer DEFAULT nextval('DTOZE_Statement_id_seq') NOT NULL,
	name varchar(30) NOT NULL,
	visibility varchar(5) DEFAULT FALSE NOT NULL,
	idTechnology integer NOT NULL,
	idType integer NOT NULL,
	idUnit integer
);

/* Vytvoreni omezeni pro tabulku DTOZE_Statement. */
ALTER TABLE DTOZE_Statement 
  ADD CONSTRAINT PK_Statement PRIMARY KEY (id);
  
ALTER TABLE DTOZE_Statement
	ADD CONSTRAINT UQ_Statement_id UNIQUE (id);
  
/* Vytvoreni indexu pro sloupce tabulky DTOZE_Statement */
CREATE INDEX IX_Statement_idTechnology
	ON DTOZE_Statement (idTechnology);
  
CREATE INDEX IX_Statement_idUnit
	ON DTOZE_Statement (idUnit);
  
CREATE INDEX IX_Statement_idType
	ON DTOZE_Statement (idType);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Application. */
CREATE SEQUENCE DTOZE_StatementType_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_StatementType */
CREATE TABLE DTOZE_StatementType ( 
	id integer DEFAULT nextval('DTOZE_StatementType_id_seq') NOT NULL,
	name varchar(50) NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_StatementType.*/   
ALTER TABLE DTOZE_StatementType 
  ADD CONSTRAINT PK_Type PRIMARY KEY (id);
  
ALTER TABLE DTOZE_StatementType
	ADD CONSTRAINT UQ_StatementType_id UNIQUE (id);
  
ALTER TABLE DTOZE_StatementType
	ADD CONSTRAINT UQ_StatementType_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_StatementType. */
CREATE SEQUENCE DTOZE_StatementValue_idProduct_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_StatementValue */
CREATE TABLE DTOZE_StatementValue ( 
	idProduct integer DEFAULT nextval('DTOZE_StatementValue_idProduct_seq') NOT NULL,
	idStatement integer NOT NULL,
	value varchar(30) NOT NULL,
	dateAddition timestamp NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_StatementValue.*/
ALTER TABLE DTOZE_StatementValue 
  ADD CONSTRAINT PK_StatementValue PRIMARY KEY (idProduct, idStatement);

/* Vytvoreni tabulky DTOZE_SurveyItem */
CREATE TABLE DTOZE_SurveyItem ( 
	idTechnology integer NOT NULL,
	idParameter integer DEFAULT 1 NOT NULL,
	idOrientation integer DEFAULT 0 NOT NULL,
	idPlaceType integer NOT NULL,
	idUnit integer NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_SurveyItem.*/
ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT PK_SurveyItem 
	PRIMARY KEY (idTechnology, idParameter, idOrientation, idPlaceType, idUnit);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Technology. */
CREATE SEQUENCE DTOZE_Technology_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Technology */
CREATE TABLE DTOZE_Technology ( 
	id integer DEFAULT nextval('DTOZE_Technology_id_seq') NOT NULL,
	name varchar(30) NOT NULL,
	information text NOT NULL,
	countProduct integer DEFAULT 0 NOT NULL,
	idType integer
);

/* Vytvoreni omezeni pro tabulku DTOZE_Technology.*/
ALTER TABLE DTOZE_Technology 
  ADD CONSTRAINT PK_Technology PRIMARY KEY (id);

ALTER TABLE DTOZE_Technology
	ADD CONSTRAINT UQ_Technology_id UNIQUE (id);

ALTER TABLE DTOZE_Technology
	ADD CONSTRAINT UQ_Technology_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_TechnologyType. */
CREATE SEQUENCE DTOZE_TechnologyType_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_TechnologyType. */
CREATE TABLE DTOZE_TechnologyType ( 
	id integer DEFAULT nextval('DTOZE_TechnologyType_id_seq') NOT NULL,
	name varchar(50) NOT NULL,
	information text,
	idCategory integer NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_TechnologyType.*/
ALTER TABLE DTOZE_TechnologyType ADD CONSTRAINT PK_TechnologyType 
	PRIMARY KEY (id);

ALTER TABLE DTOZE_TechnologyType
	ADD CONSTRAINT UQ_TechnologyType_id UNIQUE (id);
  
ALTER TABLE DTOZE_TechnologyType
	ADD CONSTRAINT UQ_TechnologyType_name UNIQUE (name);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_Unit. */
CREATE SEQUENCE DTOZE_Unit_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_Unit */
CREATE TABLE DTOZE_Unit ( 
	id integer DEFAULT nextval('DTOZE_Unit_id_seq') NOT NULL,
	shortcut varchar(10) NOT NULL,
	name varchar(30)
);

/* Vytvoreni omezeni pro tabulku DTOZE_Unit.*/
ALTER TABLE DTOZE_Unit ADD CONSTRAINT PK_Unit 
	PRIMARY KEY (id);

ALTER TABLE DTOZE_Unit
	ADD CONSTRAINT UQ_Unit_id UNIQUE (id);
  
ALTER TABLE DTOZE_Unit
	ADD CONSTRAINT UQ_Unit_name UNIQUE (name);
  
ALTER TABLE DTOZE_Unit
	ADD CONSTRAINT UQ_Unit_shortcut UNIQUE (shortcut);

/* Vytvoreni sekvence pro sloupec id tabulky DTOZE_User. */
CREATE SEQUENCE DTOZE_User_id_seq INCREMENT 1 START 1;

/* Vytvoreni tabulky DTOZE_User */
CREATE TABLE DTOZE_User ( 
	id integer DEFAULT nextval('DTOZE_User_id_seq') NOT NULL,
	email varchar(50) NOT NULL,
	passwordHash varchar(50) NOT NULL,
	passwordSalt varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	role varchar(10) NOT NULL,
	dateLastLogin timestamp,
	countProductPosted integer DEFAULT 0 NOT NULL
);

/* Vytvoreni omezeni pro tabulku DTOZE_User.*/
ALTER TABLE DTOZE_User ADD CONSTRAINT PK_User 
	PRIMARY KEY (id);

ALTER TABLE DTOZE_User
	ADD CONSTRAINT UQ_User_email UNIQUE (email);
  
ALTER TABLE DTOZE_User
	ADD CONSTRAINT UQ_User_id UNIQUE (id);

/* Vytvareni cizich klicu */
ALTER TABLE DTOZE_Application ADD CONSTRAINT FK_Application_User 
	FOREIGN KEY (idAdmin) REFERENCES DTOZE_User (id);

ALTER TABLE DTOZE_Change ADD CONSTRAINT FK_Change_Product 
	FOREIGN KEY (idProduct) REFERENCES DTOZE_Product (id);

ALTER TABLE DTOZE_Change ADD CONSTRAINT FK_Change_StatementValue 
	FOREIGN KEY (idProduct, idStatement) REFERENCES DTOZE_StatementValue (idProduct, idStatement);

ALTER TABLE DTOZE_Change ADD CONSTRAINT FK_Change_UserConfirmed 
	FOREIGN KEY (idUserConfirmed) REFERENCES DTOZE_User (id);

ALTER TABLE DTOZE_Change ADD CONSTRAINT FK_Change_UserSended 
	FOREIGN KEY (idUserSend) REFERENCES DTOZE_User (id);
  
ALTER TABLE DTOZE_Company ADD CONSTRAINT FK_Company_Producent 
	FOREIGN KEY (idProducent) REFERENCES DTOZE_User (id);  

ALTER TABLE DTOZE_PlaceType ADD CONSTRAINT FK_PlaceType_Place 
	FOREIGN KEY (idPlace) REFERENCES DTOZE_Place (id);

ALTER TABLE DTOZE_Product ADD CONSTRAINT FK_Product_Company 
	FOREIGN KEY (idCompany) REFERENCES DTOZE_Company (id);
  
ALTER TABLE DTOZE_Product ADD CONSTRAINT FK_Product_Technology 
	FOREIGN KEY (idTechnology) REFERENCES DTOZE_Technology (id);

ALTER TABLE DTOZE_Product ADD CONSTRAINT FK_Product_userConfirmed 
	FOREIGN KEY (idUserConfirmed) REFERENCES DTOZE_User (id);

ALTER TABLE DTOZE_Product ADD CONSTRAINT FK_Product_userEdited 
	FOREIGN KEY (idUserEdited) REFERENCES DTOZE_User (id);

ALTER TABLE DTOZE_Product ADD CONSTRAINT FK_Product_userPosted 
	FOREIGN KEY (idUserPosted) REFERENCES DTOZE_User (id);

ALTER TABLE DTOZE_Statement ADD CONSTRAINT FK_Statement_Type 
	FOREIGN KEY (idType) REFERENCES DTOZE_StatementType (id);

ALTER TABLE DTOZE_Statement ADD CONSTRAINT FK_Statement_Unit 
	FOREIGN KEY (idUnit) REFERENCES DTOZE_Unit (id);

ALTER TABLE DTOZE_Statement ADD CONSTRAINT FK_Statement_Technology 
	FOREIGN KEY (idTechnology) REFERENCES DTOZE_Technology (id);

ALTER TABLE DTOZE_StatementValue ADD CONSTRAINT FK_StatementValue_Product 
	FOREIGN KEY (idProduct) REFERENCES DTOZE_Product (id);

ALTER TABLE DTOZE_StatementValue ADD CONSTRAINT FK_StatementValue_Statement 
	FOREIGN KEY (idStatement) REFERENCES DTOZE_Statement (id);

ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT FK_SurveyItem_Orientation 
	FOREIGN KEY (idOrientation) REFERENCES DTOZE_Orientation (id);

ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT FK_SurveyItem_Unit 
	FOREIGN KEY (idUnit) REFERENCES DTOZE_Unit (id);

ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT FK_SurveyItem_Parameter 
	FOREIGN KEY (idParameter) REFERENCES DTOZE_Parameter (id);

ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT FK_SurveyItem_PlaceType 
	FOREIGN KEY (idPlaceType) REFERENCES DTOZE_PlaceType (id);

ALTER TABLE DTOZE_SurveyItem ADD CONSTRAINT FK_SurveyItem_Technology 
	FOREIGN KEY (idTechnology) REFERENCES DTOZE_Technology (id);

ALTER TABLE DTOZE_Technology ADD CONSTRAINT FK_Technology_Type 
	FOREIGN KEY (idType) REFERENCES DTOZE_TechnologyType (id);

ALTER TABLE DTOZE_TechnologyType ADD CONSTRAINT FK_TechnologyType_Category 
	FOREIGN KEY (idCategory) REFERENCES DTOZE_Category (id);

/* Vytvareni funkce pro pouziti v omezeni CHECK. */
CREATE OR REPLACE FUNCTION check_user_role(INTEGER) RETURNS BOOLEAN AS '
DECLARE
    tmpRole VARCHAR(10);
BEGIN
SELECT role INTO tmpRole FROM DTOZE_user WHERE id = $1;      
     IF FOUND THEN
      RETURN (tmpRole LIKE ''producent'');
     ELSE 
      RETURN true;
     END IF;
 END;
' LANGUAGE plpgsql;

/* Vytvoreni checku, nemohl byt vytvorem spolecne s tabulkou DTOZE_Company, protoze se tyka i tabulky DTOZE_USER, ktera neni jeste tou dobou vytvorena a pouziva funkci, kterou take definuji pozdeji. */
ALTER TABLE DTOZE_Company ADD CONSTRAINT valide_user 
  CHECK (check_user_role(idProducent));

/* Vytvareni funkce pro pouziti v triggru pro odvozene sloupce. Pred upravovanim hodnot se dotazuje na stav (status) produktu a dle toho jsou provadeny zmeny. Funkce by mohla byt jeste optimalizovana, aby obsahovala mene radek, ale z duvodu zachovani prehlednosti (co probíhá při jaké operaci) je ponecháno dotazování na TG_OP.*/

CREATE OR REPLACE FUNCTION update_productCounters() RETURNS TRIGGER AS '
BEGIN
    IF TG_OP = ''DELETE'' THEN
        IF OLD.status LIKE ''OK'' THEN
          UPDATE DTOZE_User SET countProductPosted = countProductPosted - 1 WHERE id = OLD.idUserPosted;
          UPDATE DTOZE_Company SET countProduct = countProduct - 1 WHERE id = OLD.idCompany;
          UPDATE DTOZE_Technology SET countProduct = countProduct - 1 where id = OLD.idTechnology;
        END IF;
        RETURN OLD;
    END IF;
    IF TG_OP = ''INSERT'' THEN
        IF NEW.status LIKE ''OK'' THEN
          UPDATE DTOZE_User SET countProductPosted = countProductPosted + 1 WHERE id = NEW.idUserPosted;
          UPDATE DTOZE_Company SET countProduct = countProduct + 1 WHERE id = NEW.idCompany;
          UPDATE DTOZE_Technology SET countProduct = countProduct + 1 where id = NEW.idTechnology;
        END IF;
        RETURN NEW;
    END IF;
    IF TG_OP = ''UPDATE'' THEN
        IF (OLD.status LIKE ''OK'' AND NEW.status LIKE ''OK'') THEN
          IF (OLD.idUserPosted != NEW.idUserPosted) THEN
            UPDATE DTOZE_User SET countProductPosted = countProductPosted + 1 WHERE id = NEW.idUserPosted;
            UPDATE DTOZE_User SET countProductPosted = countProductPosted - 1 WHERE id = OLD.idUserPosted; 
          END IF;
          IF OLD.idCompany != NEW.idCompany THEN
            UPDATE DTOZE_Company SET countProduct = countProduct + 1 WHERE id = NEW.idCompany;
            UPDATE DTOZE_Company SET countProduct = countProduct - 1 WHERE id = OLD.idCompany;
          END IF;
          IF OLD.idTechnology != NEW.idTechnology THEN
            UPDATE DTOZE_Technology SET countProduct = countProduct + 1 where id = NEW.idTechnology;
            UPDATE DTOZE_Technology SET countProduct = countProduct - 1 where id = OLD.idTechnology;
          END IF;
        ELSEIF (OLD.status NOT LIKE ''OK'') AND (NEW.status LIKE ''OK'') THEN
          UPDATE DTOZE_User SET countProductPosted = countProductPosted + 1 WHERE id = NEW.idUserPosted;
          UPDATE DTOZE_Company SET countProduct = countProduct + 1 WHERE id = NEW.idCompany;
          UPDATE DTOZE_Technology SET countProduct = countProduct + 1 where id = NEW.idTechnology;
        ELSEIF (OLD.status LIKE ''OK'') AND (NEW.status NOT LIKE ''OK'') THEN
          UPDATE DTOZE_User SET countProductPosted = countProductPosted - 1 WHERE id = OLD.idUserPosted;
          UPDATE DTOZE_Technology SET countProduct = countProduct - 1 where id = OLD.idTechnology;
          UPDATE DTOZE_Company SET countProduct = countProduct - 1 WHERE id = OLD.idCompany;
        END IF;
        RETURN NEW;
    END IF;
END;
' LANGUAGE 'plpgsql';

/* Smazani triggru pokud existuje. */
DROP TRIGGER TGR_update_productCounters ON DTOZE_Product;  

/* Vytvareni triggru pro odvozene sloupce. */
CREATE TRIGGER TGR_update_productCounters
AFTER INSERT OR DELETE OR UPDATE ON DTOZE_Product
FOR EACH ROW EXECUTE PROCEDURE update_productCounters();

/* Vložení testovacích dat. */
INSERT INTO "public".dtoze_category ("name", information) 
	VALUES ('Vodní energie', 'Voda je zdrojem energie.');
INSERT INTO "public".dtoze_category ("name", information) 
	VALUES ('Solární energie', 'Slunce  je zdrojem energie.');
INSERT INTO "public".dtoze_category ("name", information) 
	VALUES ('Větrná energie', 'Vítr  je zdrojem energie.');
INSERT INTO "public".dtoze_category ("name", information) 
	VALUES ('Biomasa', 'Biomasa je zdrojem energie.');
INSERT INTO "public".dtoze_category ("name", information) 
	VALUES ('Geoterální energie', 'Země je zdrojem energie.');
  
/* Upravit cizi klice aby sedeli s id*/
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Fotovoltaika', 'Infromace o fotovoltaice.', 1) ;
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Teplovzdušný solární panel', 'Infromace o panelech.', 1);
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Solární kolektor', 'Infromace o solárním kolektoru.', 1);
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Vodní elektrárna', 'Infromace o vodní elektrárně.', 2);
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Větrná elektrárna', 'Infromace o větrné elektrárně.', 3);
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Spalování', 'Infromace o spalování.', 4);
INSERT INTO "public".dtoze_technologytype ("name", information, idcategory) 
	VALUES ('Tepelná čerpadla', 'Infromace o čerpadlech.', 5);
  
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('FTV panel', 'Informace o technologii.', DEFAULT, 1);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Panel', 'Informace o technologii.', DEFAULT, 1);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('FTT panel', 'Informace o technologii.', DEFAULT, 1);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Mikrohydrotechnologie', 'Informace o technologii.', DEFAULT, 2);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Horizontální větrná elektrárna', 'Informace o technologii.', DEFAULT, 3);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Vertikální větrná elektrárna', 'Informace o technologii.', DEFAULT, 3);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Spalování tuhé biomasy', 'Informace o technologii.', DEFAULT, 4);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Bioplyn/Biopaliva', 'Informace o technologii.', DEFAULT, 4);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Voda-Voda', 'Informace o technologii.', DEFAULT, 5);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Země-Voda', 'Informace o technologii.', DEFAULT, 5);
INSERT INTO "public".dtoze_technology ("name", information, countproduct, idtype) 
	VALUES ('Vzduch-Voda', 'Informace o technologii.', DEFAULT, 5);
  
INSERT INTO "public".dtoze_user (email, passwordhash, passwordsalt, "name", "role", datelastlogin, countproductposted) 
	VALUES ('adam@novak.cz', '0e18f44c1fec03ec4083422cb58ba6a09ac4fb2a', '0e18f44c1fec03ec4083422cb58ba6a09ac4fb2a', 'Adam Novák', 'admin', CURRENT_TIMESTAMP, DEFAULT);
INSERT INTO "public".dtoze_user (email, passwordhash, passwordsalt, "name", "role", datelastlogin, countproductposted) 
	VALUES ('jan@silny.cz', '14e793d896ddc8ca6911747228e86464cf420065', '14e793d896ddc8ca6911747228e86464cf420065', 'Jan Silný', 'admin', CURRENT_TIMESTAMP, DEFAULT);
INSERT INTO "public".dtoze_user (email, passwordhash, passwordsalt, "name", "role", datelastlogin, countproductposted) 
	VALUES ('julie@krusna.cz', '8d32267b6b4884cf35adeaccde2b6857ae11aace', '8d32267b6b4884cf35adeaccde2b6857ae11aace', 'Julie Krušná', 'admin', CURRENT_TIMESTAMP, DEFAULT);
INSERT INTO "public".dtoze_user (email, passwordhash, passwordsalt, "name", "role", datelastlogin, countproductposted) 
	VALUES ('john@david.com', 'a51dda7c7ff50b61eaea0444371f4a6a9301e501', 'a51dda7c7ff50b61eaea0444371f4a6a9301e501', 'John David', 'producent', CURRENT_TIMESTAMP, DEFAULT);
INSERT INTO "public".dtoze_user (email, passwordhash, passwordsalt, "name", "role", datelastlogin, countproductposted) 
	VALUES ('tomas@nekonecny.cz', '2bc6038c3dfca09b2da23c8b6da8ba884dc2dcc2', '2bc6038c3dfca09b2da23c8b6da8ba884dc2dcc2', 'Tomáš Nekonečný', 'producent', CURRENT_TIMESTAMP, DEFAULT);

INSERT INTO "public".dtoze_company (companyname, webpage, phonenumber, street, streetnumber, city, country, postalcode, numberviews, countproduct, idproducent) 
	VALUES ('Eko s.r.o.', 'www.eko.cz', '+420777111222', 'Nová', '2/1100', 'Praha', 'Česká republika', '140 00', DEFAULT, DEFAULT, NULL);
INSERT INTO "public".dtoze_company (companyname, webpage, phonenumber, street, streetnumber, city, country, postalcode, numberviews, countproduct, idproducent) 
	VALUES ('Karel a.s.', 'www.karelas.cz', '420777111223', 'Mladá', '57', 'Brno', 'Česká republika', '130 00', DEFAULT, DEFAULT, NULL);
INSERT INTO "public".dtoze_company (companyname, webpage, phonenumber, street, streetnumber, city, country, postalcode, numberviews, countproduct, idproducent) 
	VALUES ('Tepelná čerpadla a.s.', 'www.tepelnacerpadla-praha.cz', '420777111224', 'Hezká', '121', 'Plzeň', 'Česká republika', '323 23', DEFAULT, DEFAULT, 5);
INSERT INTO "public".dtoze_company (companyname, webpage, phonenumber, street, streetnumber, city, country, postalcode, numberviews, countproduct, idproducent) 
	VALUES ('EKO log', 'www.ekolog.com', '420777111225', 'Old Square', '6', 'Vienna', 'Austria', '110 00', DEFAULT, DEFAULT, 4);

INSERT INTO "public".dtoze_statementtype ("name") 
	VALUES ('Další údaje o výkonu');
INSERT INTO "public".dtoze_statementtype ("name") 
	VALUES ('Technologické údaje');
INSERT INTO "public".dtoze_statementtype ("name") 
	VALUES ('Provozní údaje');
INSERT INTO "public".dtoze_statementtype ("name") 
	VALUES ('Ekonomické a administrativní údaje');
INSERT INTO "public".dtoze_statementtype ("name") 
	VALUES ('Hlavní údaje');
  
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('kW', 'kilowatt');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('m2', 'čtvereční metr');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('kg', 'kilogram');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('let', 'let');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('dB', 'decibel');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('l', 'litr');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('CZK', 'česká koruna');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('EU', 'euro');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('USD', 'americký dolar');
INSERT INTO "public".dtoze_unit (shortcut, "name") 
	VALUES ('m', 'metr');
  
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Typ', 'true', 1, 5, NULL);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Jmenovitý výkon', 'true', 1, 5, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Maximální výkon', 'true', 1, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 200 W/m2', 'false', 1, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 400 W/m2', 'false', 1, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Plocha', 'true', 1, 2, 2);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Hmotnost', 'true', 1, 2, 3);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Vhodné baterie', 'false', 1, 3, NULL);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Udávaná životnost', 'false', 1, 4, 4);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Typ', 'true', 5, 5, NULL);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Jmenovitý výkon', 'true', 5, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 6 m/s', 'false', 5, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 8 m/s', 'false', 5, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 10 m/s', 'false', 5, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Výkon při 12 m/s', 'false', 5, 1, 1);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Provozní výška', 'false', 5, 2, NULL);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Zábor plochy', 'false', 5, 2, 2);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Hmotnost', 'false', 5, 3, 3);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Hluk', 'false', 5, 3, 5);
INSERT INTO "public".dtoze_statement ("name", visibility, idtechnology, idtype, idunit) 
	VALUES ('Poskytovaná záruka', 'false', 5, 4, 4);
  
INSERT INTO "public".dtoze_product ("name", imageurl, information, dateposting, dateconfirmation, dateediting, numberviews, status, adminmessage, iduserposted, iduserconfirmed, iduseredited, idcompany, idtechnology) 
	VALUES ('Solar ES-1-2', 'www.dtoze.cz/image.png', 'Výkonný FTV panel.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, DEFAULT, 'OK', 'OK', 1, NULL, 1, 1, 1);
INSERT INTO "public".dtoze_product ("name", imageurl, information, dateposting, dateconfirmation, dateediting, numberviews, status, adminmessage, iduserposted, iduserconfirmed, iduseredited, idcompany, idtechnology) 
	VALUES ('Solar ES-1-1', 'www.dtoze.cz/image1.png', 'Starší verze výrobku Solar ES-1-2. Méně výkonný.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, DEFAULT, 'OK', 'OK', 1, NULL, 1, 1, 1);
INSERT INTO "public".dtoze_product ("name", imageurl, information, dateposting, dateconfirmation, dateediting, numberviews, status, adminmessage, iduserposted, iduserconfirmed, iduseredited, idcompany, idtechnology)
	VALUES ('Větrná elektrárna mini VW-123', 'www.dtoze.cz/image2.png', 'Větrná elektrárna mini VW-123.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, DEFAULT, 'OK', 'OK', 4, 1, 4, 4, 5);

  

  

