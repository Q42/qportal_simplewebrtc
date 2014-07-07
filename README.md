Qportal - SimpleWebRTC
====================
 <h1>/admin</h1>
<p>
Op de admin pagina kunnen twee locaties toegevoegd worden (in ons geval Amsterdam & Den Haag).<br /> 
Er is een limiet van twee locaties. Meteor houd deze bij in de collection locations.<br />
Ook kunnen er schermen worden toegevoegd, bijvoorbeeld Q020 - Keuken. Meteor houd deze bij in de collections screens.<br />
Een scherm kan worden gekoppeld aan een locatie door op een scherm te klikken en vervolgens op de naam van de locatie.<br />
Standaard worden schermen aan elkaar gekoppeld op basis van volgorde dus het scherm op positie 1 onder Amsterdam wordt gekoppeld aan het scherm op positie 1 onder Den Haag <i>(moet nog op een 'nettere' manier gebeuren!)</i> <br />
Deze schermen krijgen dezelfde 'room'. Waardoor alleen die streams elkaar zien. <br /><br />
Het is ook mogelijk om alle streams in 1 room te gooien, echter bij meer dan 5 'peers' worden de verbinding onbetrouwbaar (streams die afgesloten zijn blijven zichtbaar als zwarte schermen, duurt lang voor een stream aan de room is toegevoegd). <br />
Om die reden is er gekozen voor elk hun eigen room.
</p>

<h4>/client/admin</h4>
<ul>
<li>admin.coffee</li>
<li>admin.html</li>
<li>admin_model.coffee</li>
</ul>

<h1>/portal</h1>
<p> Om een videoverbinding op te zetten kan naar /portal worden genavigeerd. <br />
Hier staat een lijst van schermen (die onder /admin is aangemaakt en gekoppeld aan een ander scherm).<br />
Selecteer het scherm en klik vervolgens op allow (auto allow is mogelijk over een beveiligde verbinding) om het streamen te starten.<br />
Indien de tegenhanger aan het streamen is zal zijn webcamstream zichtbaar zijn, zo niet is er een leeg scherm waar uiteindelijk de remote stream in komt. </p>

<h4>/client/portal</h4>
<ul>
<li>portal.coffee</li>
<li>portal.html</li>
<li>portal_model.coffee</li>
</ul>

<b><u>SimpleWebRTC</u></b>
<p>
Wordt gebruikt voor de videostream (portal.coffee).<br />
Er word een simpleWebRTC object aangemaakt met als parameters de DOM elementen voor de local video (eigen video stream), en de remote stream.<br /></p>
<ul>
<li>webrtc.on('joinroom') -> de room die we joinen</li>
<li>webrtc.on('videoAdded') -> wanneer een remote peer verbind</li>
<li>webrtc.on('localstream') -> wanneer de local stream beschikbaar komt, wordt gebruikt om de microfoon te muten zodra we een local stream hebben</li>
</ul>

<b><u>keyBinds</u></b>
<p>De vaste knoppen zijn eigenlijk toetsenborden: <br />
<u>Wanneer de knop is ingedrukt -> Q </u><br />
Unmute de microfoon voor 20 seconde en zet een readyToTakeOver waarde op false.<br />
Deze variabele zorgt ervoor dat wanneer een ander scherm met dit scherm wilt verbinden (door middel van nextScreen) dit niet kan, er word een melding getoont dat het scherm in gebruik is.<br />
Er begint een timer te lopen van 20 seconde, wanneer deze tijd verstreken is word de microfoon weer gemute en de readyToTakeOver op true gezet. </p>

<p><u>Wanneer de knop word losgelaten -> A</u><br />
Geen actie</p>

<p>Wanneer de pijltjestoetsen (rechts en links) worden ingedrukt gaan we naar het volgende scherm <i>(previous scherm is nog niet gebouwd)</i>.<br />
Indien het scherm niet bezet is (readyToTakeOver) word er een temp + schermId roomname aangemaakt en 'joinen' beide schermen deze room.<br />
Zodra we op een pijltjestoets drukken en weer naar het volgende scherm gaan krijgt het huidige scherm zijn defaultRoomName terug en word het volgende scherm in de tijdelijke room geplaatst.<br />
Zodra we terug komen bij onze originele tegenhanger wordt onze room weer op de defaultRoomName waarde gezet.</p>

<p><b><u>Tablets</u></b><br />
Wanneer er op het scherm geklikt word (dmv. mouseclick) wordt fullscreen aangezet. Wanneer fullscreen al aan is kan na weer tappen de microfoon geunmute worden.</p>

<p><b><u>Meteor</u></b><br />
<u>screens:</u><br /></p>
<ul>
<li>_id -> Het ID van een scherm </li>
<li>defaultRoomName -> Is de room die zijn originele tegenhanger ook als defaultRoomName heeft (bijvoorbeeld Q020 - Keuken en Q070 - Keuken zijn 'default' tegenhangers van elkaar).</li>
<li>isTalking -> Boolean die we bijhouden zodra een scherm praat is deze true anders false - kan gebruikt worden om gebruiker feedback te geven dat de microfoon van de tegenhanger geunmute is. (word op dit moment niks mee gedaan)</li>
<li>location -> Het id van de locatie</li>
<li>name -> Naam van het scherm</li>
<li>readyToTakeOver -> Boolean die bijhoud of we met het scherm kunnen verbinden bij false toon een bericht dat het scherm in gebruik is bij true kan er met het scherm worden verbonden</li>
<li>room -> De room waar het scherm zich in bevind, deze wordt aangepast zodra we naar een ander scherm navigeren (met nextScreen bijvoorbeeld)</li>
<li>sessionId -> Sessie ID die de stream van SimpleWebRTC krijgt. (word op dit moment niks mee gedaan)</li>
</ul>

<p><u>locations:</u></p>
<ul>
<li>_id -> ID van de locatie</li>
<li>name -> naam van de locatie</li>
</ul>
