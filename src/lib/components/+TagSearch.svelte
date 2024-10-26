<script lang="ts">
    import { Button } from "flowbite-svelte";

    // Available tags for the UI
    const tags: string[] = [
        "Bebauungsplan 1", "Solaranlage 2", "Luftbilder 3", "Stadtplanung 4", "Geoinformation 5",
        "Umweltschutz 6", "Energieeffizienz 7", "Verkehrsplanung 8", "Wasserschutz 9", "Bodenanalyse 10",
        "Naturdenkmal 11", "Gebäudeenergie 12", "Klimaschutz 13", "Abfallwirtschaft 14", "Naturschutzgebiet 15",
        "Umweltverträglichkeit 16", "Regenerative Energie 17", "Stromnetz 18", "Wärmepumpe 19", "Smart City 20",
        "Lärmschutz 21", "Baumkataster 22", "Solarkataster 23", "Energieberatung 24", "Verkehrsüberwachung 25",
        "Gebäudesanierung 26", "Grünflächenpflege 27", "Baugrunduntersuchung 28", "Bauleitplanung 29", "Biotopkartierung 30",
        "Stromspeicher 31", "Wasseraufbereitung 32", "Flächennutzungsplan 33", "Energieverbrauch 34", "Lichtverschmutzung 35",
        "Energiesparen 36", "Nachhaltigkeit 37", "Biodiversität 38", "Luftqualität 39", "Küstenschutz 40",
        "Naturnahe Flächen 41", "Stromerzeugung 42", "Solarpotenzial 43", "Bauprojektdaten 44", "Abwasserentsorgung 45",
        "Verkehrsflussanalyse 46", "Grundstücksbewertung 47", "Wasserqualität 48", "Feinstaubmessung 49", "Abfallbeseitigung 50",
        "Regenwassernutzung 51", "Straßenbauplanung 52", "Umweltprüfung 53", "Hochwasserschutz 54", "Flussrenaturierung 55",
        "Energieausweis 56", "Windkraftanlage 57", "Schallschutz 58", "Umweltmonitoring 59", "Recycling 60",
        "Verkehrsmodellierung 61", "Solarthermie 62", "Ökologischer Landbau 63", "Fassadendämmung 64", "Grundwasseranalyse 65",
        "Bodenversiegelung 66", "Wärmedämmung 67", "Energiespeicherung 68", "Photovoltaik 69", "Stadtklima 70",
        "Elektromobilität 71", "Erneuerbare Energien 72", "Luftverschmutzung 73", "Klimaresilienz 74", "Umweltzonen 75",
        "Klimaanpassung 76", "Naturraumanalyse 77", "Grünflächenmanagement 78", "Bodenökologie 79", "Stadtsanierung 80",
        "Mobilitätskonzept 81", "Umweltforschung 82", "Verkehrslärmschutz 83", "Energiepolitik 84", "Lärmkartierung 85",
        "Solarenergie 86", "Wasserkraft 87", "Energieeffizienzberatung 88", "Stadterneuerung 89", "Umweltbewusstsein 90",
        "Nachhaltiges Bauen 91", "Energieaudit 92", "Stadtrückbau 93", "Klimamodellierung 94", "Landschaftsschutz 95",
        "Urbanes Grün 96", "Umweltverträglichkeitsstudie 97", "Abfallwirtschaftsplanung 98", "Nachhaltigkeitskonzept 99", "Kreislaufwirtschaft 100"
    ];

    let searchTerm: string = "";
    let selectedTags: string[] = [];

    let countOfShownTags: number = 20;

    // Filter function based on search term
    let filteredTags: string[] = tags;

    let filterTags = () => {
        filteredTags = tags.filter(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    };

    function selectTag(param: string) {
        if (!selectedTags.includes(param)) {
            selectedTags = [...selectedTags, param];

        } else {
            selectedTags = selectedTags.filter(tag => tag !== param);
        }
        console.log(selectedTags);
    }

    function toggleShownTags() {
        if (countOfShownTags === 20) {
            countOfShownTags = tags.length;
            document.getElementById("toggleButton").innerHTML = "Weniger Tags anzeigen";
        } else {
            countOfShownTags = 20;
            document.getElementById("toggleButton").innerHTML = "Alle Tags anzeigen";
        }
    }
</script>

<!-- Main Container -->
<div class="p-4 max-w-lg mx-auto">
    
    <!-- Search Input -->
    <div class="mb-4">
        <label for="tag-search" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400">
            Dokumentensuche nach Tags
        </label>
        <input
            bind:value={searchTerm}
            on:input={filterTags}
            type="text"
            id="tag-search"
            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            placeholder="Nach Tags suchen..."
        />
    </div>

    <!-- Available Tags -->
    <div class="flex flex-wrap gap-2">
        {#each filteredTags.slice(0, countOfShownTags) as tag}
            <Button on:click={() => selectTag(tag)} color={selectedTags.includes(tag) ? 'green' : 'light'}>
                {tag}
            </Button>
        {/each}
    </div>
    <!-- Button fopr show all tags -->
    <Button id="toggleButton" on:click={() => toggleShownTags()} color="blue" class="mt-4">
        Alle Tags anzeigen
    </Button>
</div>
