<script lang="ts">
    import { Label, Fileupload, Button, Helper } from 'flowbite-svelte';

    export let endpoint;
    export let acceptedFileTypes;
    let file = null; // Store only one file
    //const acceptedFileTypes = ['image/png', 'image/jpeg']; // Only allow PNG and JPEG for this example

    // Handle file selection
    const handleFileChange = (event) => {
        const selectedFile = event.target.files[0];
        if (selectedFile) {
            if (validateFileType(selectedFile)) {
                file = selectedFile; // Set the file if valid
            } else {
                alert('Invalid file type. Please upload an image (PNG, JPEG).');
                event.target.value = null; // Reset the file input
            }
        }
    };

    // Validate file type
    const validateFileType = (file) => {
        return acceptedFileTypes.includes(file.type);
    };

    // Show the selected file's name
    const showFileName = () => {
        return file ? file.name : 'No file selected';
    };

    // Submit the file to the server
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
            const json = await res.json();
            console.log('Response from server:', json);
        } catch (error) {
            console.error('Error uploading file:', error);
        }
    };
</script>

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
