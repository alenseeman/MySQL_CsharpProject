use is_ski;

-- grad
insert into grad values('79101','Prijedor','BiH');
insert into grad values('78108','Banja Luka','BiH');
insert into grad values('71000','Sarajevo','BiH');
insert into grad values('78400','Gradiska','BiH');
insert into grad values('74101','Doboj','BiH');

-- osobe

insert into osoba values('0211993111946','Alen','Semanic','79101');
insert into osoba values('2111993163302','Idriz','Jakupovic','79101');

insert into osoba values('1111999163302','Radnik','Radnikovic','78108');
insert into osoba values('2211990143304','Serviser','Servisevic','78400');

insert into zaposleni values('1111999163302');
insert into zaposleni values('2211990143304');

insert into radnik values('1111999163302');
insert into serviser values('2211990143304');

insert into korisnik values('0211993111946');
insert into korisnik  values('2111993163302');


-- telefoni
insert into telefon_osoba values('+38765028000','1111999163302');
insert into telefon_osoba values('+38765028999','2211990143304');


insert into telefon_osoba values('+38765028476','0211993111946');
insert into telefon_osoba values('+38765028593','2111993163302');




insert into banka values ('1','78108','UniCredit Banka');
insert into banka values ('2','78108','Nova Banka');
insert into banka values ('3','78108','Addiko Banka');


insert into telefon_banka values('+38751243200','1');

insert into telefon_banka values('+38751217292','2');

insert into telefon_banka values('+38751329472','2');

insert into telefon_banka values('+38751241950','2');


insert into telefon_banka values('+38751241800','3');

insert into telefon_banka values('+38770340440','3');

insert into telefon_banka values('+38751333300','3');


-- snowboard stilovi
insert into stil values('1','Slobodni stil');
insert into stil values('2','Park/Jib');
insert into stil values('3','Slobodna voznja');
insert into stil values('4','Powder');
insert into stil values('5','Planinski');
insert into stil values('6','Trkacki');
insert into stil values('7','Razdvojeni');
insert into stil values('8','Dualni');

insert into proizvodjac values('1','Burton');
insert into proizvodjac values('2','K2');
insert into proizvodjac values('3','Ride');
insert into proizvodjac values('4','Rome SDS');
insert into proizvodjac values('5','Lib Tech');
insert into proizvodjac values('6','Jones');
insert into proizvodjac values('7','Arbor');
insert into proizvodjac values('8','GNU');
insert into proizvodjac values('9','Never Summer Industries');
insert into proizvodjac values('10','Capita');
insert into proizvodjac values('11','Salomon');
insert into proizvodjac values('12','DC');

insert into tip values('1','Buce');
insert into tip values('2','Pancerice');


insert into racun values('123456745676789',current_date(),1,'Tekuci');
insert into racun values('552456745676789',current_date(),3,'Tekuci');
insert into racun values('195656547076789',current_date(),2,'Tekuci');
insert into racun values('506654767089812',current_date(),2,'Tekuci');

insert into racun_osoba values('123456745676789','0211993111946');
insert into racun_osoba values('552456745676789','1111999163302');
insert into racun_osoba values('195656547076789','2211990143304');


insert into racun_firma values('506654767089812');
insert into ugovor values ('1','2017-09-01','2019-09-01',600,'1111999163302');
insert into ugovor values ('2','2017-09-01','2019-09-01',600,'2211990143304');

insert into ski_oprema (IdOpreme,Naziv,IdProizvodjaca,Cijena,Boja,Duzina,GodinaProizvodnje,Nedostupan) values(1,'First Call',11,15,'Crno-zuta',162,2016,0);
insert into snowboard values(1,0,4);
insert into ski_oprema (IdOpreme,Naziv,IdProizvodjaca,Cijena,Boja,Duzina,GodinaProizvodnje,Nedostupan) values(2,'Premiere',11,20,'Crveno-crna',157,2017,0);
insert into snowboard values(2,0,4);

insert into ski_oprema (IdOpreme,Naziv,IdProizvodjaca,Cijena,Boja,Duzina,GodinaProizvodnje,Nedostupan) values(3,'Premiere',11,20,'Crveno-crna',163,2017,0);
insert into snowboard values(3,0,4);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(4,'Crno-bijela',151,2017,15,'Super 8',0,11);
insert into snowboard values(4,0,5);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(6,'Crni',150,2016,10,'Pulse',0,11);
insert into snowboard values(6,1,1);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(5,'Crno-bijela',155,2017,15,'Assassin',0,11);
insert into snowboard values(5,0,1);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(7,'Crno-zuti',148,2017,15,'Sleepwalker',0,11);
insert into snowboard values(7,0,2);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(1,43,10,'Crna',0,'Synapse',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(2,42,10,'Crna',0,'Synapse',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(3,45,10,'Crna',0,'Synapse',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(4,46,10,'Crna',0,'Synapse',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(5,40,10,'Crna',0,'Synapse',11,1);
insert into ski_obuca  (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(6,38,10,'Crna',0,'Synapse',11,1);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(7,44,10,'Siva',0,'Launch Lace',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(8,41,10,'Siva',0,'Launch Lace',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(9,43,10,'Siva',0,'Launch Lace',11,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(10,44,10,'Siva',0,'Launch Lace',11,1);
insert into ski_obuca  (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(11,37,10,'Siva',0,'Launch Lace',11,1);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(12,39,10,'Crna',0,'Invader',1,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(13,42,10,'Crna',0,'Invader',1,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(14,45,10,'Crna',0,'Invader',1,1);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(15,45,12,'Bijela',0,'Ruler',1,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(16,43,12,'Bijela',0,'Ruler',1,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(17,40,12,'Bijela',0,'Ruler',1,1);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(18,38,12,'Bijela',0,'Ruler',1,1);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(8,'Plava',180,2017,10,'Chopper',0,1);
insert into snowboard values(8,0,5);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(9,'Bijela',150,2017,10,'Kilroy process',0,1);
insert into snowboard values(9,0,2);


insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(10,'Crna',152,2017,20,'Family Tree Anti-Social',0,1);
insert into snowboard values(10,0,7);


insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(11,'Siva',163,2017,20,'Flight Attendant',0,1);
insert into snowboard values(11,0,7);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(12,'Zelena',156,2017,15,'Fish',0,1);
insert into snowboard values(12,0,4);


insert into proizvodjac values (13,'Nordica');
-- id boja duzina GP cijena 0,0, naziv,0,proizvodjac
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(13,'Siva',151,2017,15,'Enforcer 93',0,13);
insert into skije values(13,65);


insert into proizvodjac values (14,'Rossignol');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(14,'Zeleno-crna',172,2017,20,'Experience 88 HD',0,14);
insert into skije values(14,90);

insert into proizvodjac values (15,'Line');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(15,'Tamno plava',165,2016,10,'Sick Day 88',0,15);
insert into skije values(15,80);


insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(16,'Plava',160,2017,15,'QST 99',0,11);
insert into skije values(16,75);

insert into proizvodjac values (16,'Volkl');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(17,'Crna',145,2017,15,'Kendo',0,16);
insert into skije values(17,55);

insert into proizvodjac values (17,'Head');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(18,'Tamno-plava',172,2017,15,'Kore 93',0,17);
insert into skije values(18,90);

insert into proizvodjac values (18,'Blizzard');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(19,'Crna',165,2017,15,'Brahma 88',0,18);
insert into skije values(19,75);

-- insert into proizvodjac values (14,'Rossignol');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(20,'Crno-zuta',150,2017,15,'Pinnacle 95',0,2);
insert into skije values(20,60);

insert into proizvodjac values (19,'Armada');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(21,'Ljubicasta',120,2017,10,'Invictus 99 Ti',0,19);
insert into skije values(21,40);

insert into proizvodjac values (20,'Nordica');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(22,'Ljubicasta',115,2016,10,'Navigator 85',0,20);
insert into skije values(22,45);

insert into proizvodjac values (21,'Fisher');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(23,'Siva',175,2017,20,'Pro Mtn 95 Ti',0,21);
insert into skije values(23,80);

-- insert into proizvodjac values (20,'Nordica');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(24,'Crna',150,2017,20,'Soul 7 HD',0,14);
insert into skije values(24,65);

insert into proizvodjac values (22,'Atomic');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(25,'Plava',100,2017,10,'Vintage',0,22);
insert into skije values(25,30);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(26,'Crno-bijela',185,2017,20,'Sir Francis Bacon 104',0,15);
insert into skije values(26,100);

insert into proizvodjac values (23,'Dynastar');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(27,'Tamno plava',150,2017,15,'Legend X',0,23);
insert into skije values(27,65);


insert into proizvodjac values (24,'Kastle');
insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(28,'Crno-zelena',165,2017,25,'FX95 HP',0,24);
insert into skije values(28,80);


insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(29,'Zelena',165,2017,10,'Smash 7',0,14);
insert into skije values(29,80);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca)  values(30,'Zelena',140,2017,10,'Smash 7',0,14);
insert into skije values(30,60);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(31,'Zelena',175,2017,10,'Smash 7',0,14);
insert into skije values(31,90);

insert into ski_oprema (IdOpreme,Boja,Duzina,GodinaProizvodnje,Cijena,Naziv,Nedostupan,IdProizvodjaca) values(32,'Zelena',120,2017,10,'Smash 7',0,14);
insert into skije values(32,50);

insert into proizvodjac values (25,'Lange');
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(19,43,10,'Crna',0,'RX 120',25,2);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(20,40,10,'Crna',0,'RX 120',25,2);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(21,41,10,'Crna',0,'RX 120',25,2);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(22,45,10,'Crna',0,'RX 120',25,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(23,46,10,'Crna',0,'RX 120',25,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(24,38,10,'Crna',0,'RX 120',25,2);


insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(25,43,10,'Plava',0,'X-Pro 120',11,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(26,36,10,'Plava',0,'X-Pro 120',11,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa)  values(27,39,10,'Plava',0,'X-Pro 120',11,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(28,42,10,'Plava',0,'X-Pro 120',11,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(29,45,10,'Plava',0,'X-Pro 120',11,2);

insert into proizvodjac values (27,'Dalbello');


insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(30,39,10,'Crno-zuta',0,'Panterra ID 120',27,2);

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(31,43,10,'Crno-zuta',0,'Panterra ID 120',27,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(32,47,10,'Crno-zuta',0,'Panterra ID 120',27,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(33,41,10,'Crno-zuta',0,'Panterra ID 120',27,2);

insert into proizvodjac values (26,'Tehnica');

insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(34,37,10,'Crno-zuta',0,'Cochise 120',26,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(35,41,10,'Crno-zuta',0,'Cochise 120',26,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(36,43,10,'Crno-zuta',0,'Cochise 120',26,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(37,44,10,'Crno-zuta',0,'Cochise 120',26,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(38,45,10,'Crno-zuta',0,'Cochise 120',26,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(39,47,10,'Crno-zuta',0,'Cochise 120',26,2);


insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(40,36,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(41,37,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(42,38,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(43,39,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(44,40,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(45,41,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(46,42,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(47,43,8,'Crno-zelena',0,'Alltrack',14,2);
insert into ski_obuca (IdObuce,Broj,Cijena,Boja,Nedostupan,Naziv,IdProizvodjaca,IdTipa) values(48,45,8,'Crno-zelena',0,'Alltrack',14,2);
