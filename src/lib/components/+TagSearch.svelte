<script lang="ts">
    //import { Button } from "flowbite-svelte";
    import { Input, Label, Helper, Button, Checkbox, A, Badge, P} from 'flowbite-svelte';
    import {  SearchOutline } from 'flowbite-svelte-icons';
    import { Card } from 'flowbite-svelte';
    import { GiftBoxSolid, ArrowUpRightFromSquareOutline } from 'flowbite-svelte-icons';
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

    let tagSearch: string = '';
    let selectedTags: string[] = [];

    let searchTerm: string = '';

    let countOfShownTags: number = 20;

    // Filter function based on search term
    let filteredTags: string[] = tags;

    let filterTags = () => {
        filteredTags = tags.filter(tag => tag.toLowerCase().includes(tagSearch.toLowerCase()));
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
    

    async function submitSearch(event){
        event.preventDefault();
        console.log('Text submitted');
        console.log(searchTerm);
        console.log(selectedTags);
        /*try {
            const res = await fetch('http://localhost:5000', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    query: searchTerm,
                    tags: selectedTags
                })
            });
            
            searchResults = await res.json();
            console.log('Response from server:', searchResults);
        } catch (error) {
            console.error('Error submitting text:', error);
        }*/

        searchResults = [
            {
                title: 'Per Anhalter durch die Galaxis',
                summary: 'Per Anhalter durch die Galaxis ist der Titel eines Werkes von Douglas Adams, der mit diesem Buch 1979 seinen Durchbruch als Schriftsteller hatte. Es handelt sich um einen humorvollen Science-Fiction-Roman, der in Großbritannien spielt und von den Abenteuern des Erdlings Arthur Dent im Weltraum erzählt.',
                tags: ['Science-Fiction', 'Humor', 'Britische Literatur']
            },
            {
                title: 'Der Hobbit',
                summary: 'Der Hobbit ist ein Fantasyroman des britischen Autors J. R. R. Tolkien. Erstmals veröffentlicht im Jahr 1937, erzählt das Buch die Geschichte des Hobbits Bilbo Beutlin, der auf eine abenteuerliche Reise geht, um einen Schatz zu finden, der von einem Drachen bewacht wird.',
                tags: ['Fantasy', 'Abenteuer', 'Kinderbuch']
            },
            {
                title: '1984',
                summary: '1984 ist ein dystopischer Roman des britischen Autors George Orwell, der im Jahr 1949 veröffentlicht wurde. Das Buch spielt in einem totalitären Überwachungsstaat, in dem die Bürger durch die Regierung kontrolliert und manipuliert werden.',
                tags: ['Dystopie', 'Politik', 'Gesellschaftskritik']
            }
        ];
        searchTerm = '';
        tagSearch = '';
        selectedTags = [];

        
    }
    interface SearchResult {
        title: string,
        summary: string,
        tags: string[],
    }

    let searchResults : SearchResult[] = null;
</script>

<!-- Main Container -->
<div class="p-4 max-w-lg mx-auto">
    {#if searchResults}
        {#if searchResults.length === 0}
            <P color="text-red-700 dark:text-red-500">Keine Ergebnisse</P>
        {:else}
            {#each searchResults as result}
            <div>
                <Card class="mb-2" size="xxl">
                    <h5 class="mb-2 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white">{result.title}</h5>
                    <p class="mb-3 font-normal text-gray-500 dark:text-gray-400">{result.summary}</p>
                    <a href="/" class="inline-flex items-center text-primary-600 hover:underline">
                    Datei öffnen
                    <ArrowUpRightFromSquareOutline class="w-4 h-4 ms-2.5" />
                    </a>
                    <div>
                        {#each result.tags as tag}
                            <Badge rounded>{"# " + tag}</Badge> 
                        {/each}
                    </div>
                </Card>
            </div>
            {/each}
        {/if}
    {:else}
    <form>
    <!-- Search Input -->
    <div class="grid gap-2 mb-3 md:grid-cols-1">
        <div class="mb-1">
            <Label for="text" class="mb-0">Suche nach Text</Label>
            <Input bind:value={searchTerm} type="text" id="text" placeholder="z.B. Per Anhalter durch die Galaxis"/>
            
        </div>
        <div>
            <Label for="tag-search" class="mb-1">Dokumentensuche nach Tags</Label>
            <Input
            bind:value={tagSearch}
            on:input={filterTags}
            type="text"
            id="tag-search"
            placeholder="Nach Tags suchen..."
        />
        </div>
        <Button on:click={submitSearch} class="mb-2"><SearchOutline/>Suchen</Button>
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
    <Button id="toggleButton" on:click={() => toggleShownTags()} class="mt-4">
        Alle Tags anzeigen
    </Button>
    </form>
    {/if}
</div>
