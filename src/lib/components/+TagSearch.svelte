<script lang="ts">
    //import { Button } from "flowbite-svelte";
    import { Input, Label, Helper, Button, Checkbox, A, Badge, P} from 'flowbite-svelte';
    import {  SearchOutline } from 'flowbite-svelte-icons';
    import { Card } from 'flowbite-svelte';
    import { GiftBoxSolid, ArrowUpRightFromSquareOutline } from 'flowbite-svelte-icons';
    import { onMount } from 'svelte';
    import { env } from '$env/dynamic/public'

    interface TagSearchProps {
        tags : string[];
    }


    let tags : string[] = [];
    onMount(async() => {
        console.log(env.PUBLIC_SEARCH_CLASSIC_URL);
        const res = await fetch(`${env.PUBLIC_SEARCH_CLASSIC_URL}/query_tags?hint=&limit=100`);
        let tagsJSON = await res.json();
        tags = tagsJSON.tags;
        filteredTags = tags;
    });
    console.log(tags);

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
    
    let searchResults : Documents = null;

    async function submitSearch(event){
        if (searchTerm === '' && selectedTags.length === 0) {
            console.log('No search term or tags selected');
            return;
        }

        event.preventDefault();
        console.log('Text submitted');
        console.log(searchTerm);
        console.log(selectedTags);
        try {
            const res = await fetch(`${env.PUBLIC_SEARCH_CLASSIC_URL}/query`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    query: searchTerm,
                    tags: selectedTags
                })
            });
            searchTerm = '';
            tagSearch = '';
            selectedTags = [];
            searchResults = await res.json();
            console.log('Response from server:', searchResults);
        } catch (error) {
            console.error('Error submitting text:', error);
        }
        if(searchResults){
        searchResults.documents.forEach(element => {
            console.log(element.title);
        });
    }
        
    }
    interface Documents {
        documents: SearchResult[]
    }

    interface SearchResult {
        uuid : string,
        title: string,
        short: string,
        tags: string[],
    }
 

    
</script>

<!-- Main Container -->
<div class="p-4 max-w-lg mx-auto">
    {#if searchResults}
        {#if searchResults.documents.length === 0}
            <P color="text-red-700 dark:text-red-500">Keine Ergebnisse</P>
        {:else}
            {#each searchResults.documents as result}
            <div>
                <Card class="mb-2" size="xxl">
                    <h5 class="mb-2 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white">{result.title}</h5>
                    <p class="mb-3 font-normal text-gray-500 dark:text-gray-400">{result.short}</p>
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
        <Button on:click={() => searchResults = null} class="center px-6 py-3">Neue Suche</Button>
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
