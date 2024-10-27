<script>
    import { Dropzone, Button } from 'flowbite-svelte';
  
    let files = [];

    export let endpoint;
  
    const dropHandle = (event) => {
        files = [];
        event.preventDefault();
        if (event.dataTransfer.items) {
            [...event.dataTransfer.items].forEach((item) => {
                if (item.kind === 'file') {
                    const file = item.getAsFile();
                    files.push(file);
                }
            });
        } else {
            [...event.dataTransfer.files].forEach((file) => {
                files.push(file);
            });
        }
    };
  
    const handleChange = (event) => {
        const selectedFiles = event.target.files;
        if (selectedFiles.length > 0) {
            for (let i = 0; i < selectedFiles.length; i++) {
                files.push(selectedFiles[i]);
            }
        }
    };
  
    const showFiles = (files) => {
        if (files.length === 1) return files[0].name;
        return files.map(file => file.name).join(', ').slice(0, 40) + '...';
    };

    const submitFiles = async () => {
        const formData = new FormData();
        files.forEach(file => formData.append('files', file));
        
        try {
            const res = await fetch(endpoint, {
                method: 'POST',
                body: formData
            });
            const json = await res.json();
            console.log('Response from server:', json);
        } catch (error) {
            console.error('Error uploading files:', error);
        }
    };
</script>
  
<Dropzone
    id="dropzone"
    on:drop={dropHandle}
    on:dragover={(event) => event.preventDefault()}
    on:change={handleChange}>
    <svg aria-hidden="true" class="mb-3 w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
    </svg>
    {#if files.length === 0}
        <p class="mb-2 text-sm text-gray-500 dark:text-gray-400">
            <span class="font-semibold">Click to upload</span> or drag and drop
        </p>
        <p class="text-xs text-gray-500 dark:text-gray-400">SVG, PNG, JPG or GIF (MAX. 800x400px)</p>
    {:else}
        <p>{showFiles(files)}</p>
    {/if}
</Dropzone>


<div class="flex justify-center">
    <Button on:click={submitFiles}>Daten Hochladen</Button>
</div>