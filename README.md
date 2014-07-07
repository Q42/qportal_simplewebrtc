Qportal - SimpleWebRTC
====================
 - /admin
 Op de admin pagina kunnen twee locaties toegevoegd worden (in ons geval Amsterdam & Den Haag). Er is een limiet van twee locaties. Meteor houd deze bij in de collection locations.
 Ook kunnen er schermen worden toegevoegd, bijvoorbeeld Q020 - Keuken. Meteor houd deze bij in de collections screens.
 Een scherm kan worden gekoppeld aan een locatie door op een scherm te klikken en vervolgens op de naam van de locatie.
 Standaard worden schermen aan elkaar gekoppeld op basis van volgorde dus het scherm op positie 1 onder Amsterdam wordt gekoppeld aan het scherm op positie 1 onder Den Haag (moet nog op een 'nettere' manier gebeuren!) Deze schermen krijgen dezelfde 'room'. Waardoor alleen die streams elkaar zien. Het was ook mogelijk om alle streams in 1 room te gooien, echter bij meer dan 5 'peers' worden de verbinding onbetrouwbaar (streams die afgesloten zijn blijven zichtbaar als zwarte schermen, duurt lang voor een stream aan de room is toegevoegd). Om die reden is er gekozen voor elk hun eigen room.

/client/admin
admin.coffee
admin.html
admin_model.coffee

- /portal 
Om een videoverbinding op te zetten kan naar /portal worden genavigeerd. Hier staat een lijst van schermen (die onder /admin is aangemaakt en gekoppeld aan een ander scherm)
Selecteer het scherm en klik vervolgens op allow (auto allow is mogelijk over een beveiligde verbinding) om het streamen te starten.
Indien de tegenhanger aan het streamen is zal zijn webcamstream zichtbaar zijn, zo niet is er een leeg scherm waar uiteindelijk de remote stream in komt.

/client/portal
portal.coffee
portal.html
portal_model.coffee

* SimpleWebRTC
Wordt gebruikt voor de videostream (portal.coffee).
Er word een simpleWebRTC object aangemaakt met als parameters de DOM elementen voor de local video (eigen video stream), en de remote stream.
webrtc.on('joinroom') -> de room die we joinen 
webrtc.on('videoAdded') -> wanneer een remote peer verbind
webrtc.on('localstream') -> wanneer de local stream beschikbaar komt, word gebruikt om de microfoon te muten zodra we een local stream hebben

*keyBinds
De vaste knoppen zijn eigenlijk toetsenborden:
Wanneer de knop is ingedrukt -> Q
Unmute de microfoon voor 20 seconde en zet een readyToTakeOver waarde op false.
Deze variabele zorgt ervoor dat wanneer een ander scherm met dit scherm wilt verbinden (door middel van nextScreen) dit niet kan, er word een melding getoont dat het scherm in gebruik is.
Er begint een timer te lopen van 20 seconde, wanneer deze tijd verstreken is word de microfoon weer gemute en de readyToTakeOver op true gezet. 

Wanneer de knop word losgelaten -> A
Geen actie

Wanneer de pijltjestoetsen (rechts en links) worden ingedrukt gaan we naar het volgende scherm (previous scherm is nog niet gebouwd)
Indien het scherm niet bezet is (readyToTakeOver) word er een temp + schermId roomname aangemaakt en 'joinen' beide schermen deze room.
Zodra we op een pijltjestoets drukken en weer naar het volgende scherm gaan krijgt het huidige scherm zijn defaultRoomName terug en word het volgende scherm in de temp room geplaatst.
Zodra we terug komen bij onze originele tegenhanger wordt onze room weer op de defaultRoomName waarde gezet.

*tablets:
Wanneer er op het scherm geklikt word (dmv. mouseclick) wordt fullscreen aangezet. Wanneer fullscreen al aan is kan na weer tappen de microfoon geunmute worden.

*Meteor
screens:
_id -> Het ID van een scherm 
defaultRoomName -> Is de room die zijn originele tegenhanger ook als defaultRoomName heeft (bijvoorbeeld Q020 - Keuken en Q070 - Keuken zijn 'default' tegenhangers van elkaar).
isTalking -> Boolean die we bijhouden zodra een scherm praat is deze true anders false - kan gebruikt worden om gebruiker feedback te geven dat de microfoon van de tegenhanger geunmute is. (word op dit moment niks mee gedaan)
location -> Het id van de locatie
name -> Naam van het scherm
readyToTakeOver -> Boolean die bijhoud of we met het scherm kunnen verbinden bij false toon een bericht dat het scherm in gebruik is bij true kan er met het scherm worden verbonden
room -> De room waar het scherm zich in bevind, deze wordt aangepast zodra we naar een ander scherm navigeren (met nextScreen bijvoorbeeld)
sessionId -> Sessie ID die de stream van SimpleWebRTC krijgt. (word op dit moment niks mee gedaan)

locations:
name -> naam van de locatie