<script lang="ts">
    import { Label, Fileupload, Button, Helper, Card, Badge } from 'flowbite-svelte';

    export let endpoint;
    export let acceptedFileTypes;
    let file = null; // Store only one file
    //const acceptedFileTypes = ['image/png', 'image/jpeg']; // Only allow PNG and JPEG for this example
    console.log(acceptedFileTypes);
    // Handle file selection
    const handleFileChange = (event) => {
        const selectedFile = event.target.files[0];
        if (selectedFile) {
            if (validateFileType(selectedFile)) {
                file = selectedFile; // Set the file if valid
            } else {
                alert('Invalid file type. Please upload an appropriate Filetype.');
                event.target.value = null; // Reset the file input
            }
        }
    };

    // Validate file type
    const validateFileType = (file) => {
        console.log(file.type);
        return acceptedFileTypes.includes(file.type);
    };

    // Show the selected file's name
    const showFileName = () => {
        return file ? file.name : 'No file selected';
    };

    // Submit the file to the server
    let json : result = null;
    const submitFile = async () => {
        if (!file) {
            alert('Please upload a file before submitting.');
            return;
        }

        const formData = new FormData();
        formData.append('file', file);

        try {
            const res = await fetch(endpoint, {
                method: 'POST',
                body: formData
            });
            json = await res.json();
            console.log('Response from server:', json);
        } catch (error) {
            console.error('Error uploading file:', error);
        }
        
    };
    interface result {
        title: string;
        tags: string[];
        short: string;
        transcription: string;
    }
</script>

{#if json}
    <Card class="mb-2" size="xxl">
        <h5 class="mb-2 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white">{json.title}</h5>
        <p class="mb-3 font-normal text-gray-500 dark:text-gray-400">{json.short}</p>
        <div>
            {#each json.tags as tag}
                <Badge rounded>{"# " + tag}</Badge> 
            {/each}
        </div>
    </Card>
    <div class="flex justify-center mt-4">
        <Button on:click={() => json = null} class="px-6 py-3">Upload another file</Button>
    </div>
{:else}
    <Label for="with_helper" class="pb-2">Upload file</Label>
    <Fileupload id="with_helper" class="mb-2" on:change={handleFileChange} />
    <Helper>{#each acceptedFileTypes as type}
        <span class="pr-2">{type.split('/')[1].toUpperCase()}</span>
        {/each}
    </Helper>

{#if file}
    <p class="mt-2 text-sm text-gray-700">Selected file: {showFileName()}</p>
{/if}

<div class="flex justify-center mt-4">
    <Button on:click={submitFile} class="px-6 py-3">Submit File</Button>
</div>
{/if}