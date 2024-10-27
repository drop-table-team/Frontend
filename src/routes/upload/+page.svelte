<script lang="ts">
    import { env } from '$env/dynamic/public'
    import Filemock from '$lib/components/+Filemock.svelte';
    import Textmock from '$lib/components/+Textmock.svelte';
    import ImageUpload from '$lib/components/+ImageUpload.svelte';
    import { Tabs, TabItem } from 'flowbite-svelte';
    import { onMount } from 'svelte';

    interface UploadModule {
        name: string;
        types: string[];
    } 

    let uploadModules: UploadModule[] = [];
    
    onMount(async() => {
      const res = await fetch(`${env.PUBLIC_BACKEND_BASE_URL}/modules/input`);
		  uploadModules = await res.json();
      console.log(uploadModules);
    });
</script>
  
<div class="p-8 max-w-7xl mx-auto">
    <Tabs>
      {#each uploadModules as module}
      <!--if module.type contains pdf, title should be "Dokumente", if it contains a png/jpeg/jpg, title should be "Bilder"-->      
        {#if module.types.includes('application/pdf')}
          <TabItem open title="Dokumente">
            <ImageUpload endpoint="{env.PUBLIC_BACKEND_BASE_URL}/modules/input/{module.name}", acceptedFileTypes={module.types}/>
        </TabItem>
        {:else if module.types.includes('image/png') || module.types.includes('image/jpeg') || module.types.includes('image/jpg')}
          <TabItem title="Bilder">
            <ImageUpload endpoint="{env.PUBLIC_BACKEND_BASE_URL}/modules/input/{module.name}", acceptedFileTypes={module.types}/>
        </TabItem>
        {:else if module.types.includes('audio/wav')}
          <TabItem title="Audio">
            <ImageUpload endpoint="{env.PUBLIC_BACKEND_BASE_URL}/modules/input/{module.name}", acceptedFileTypes={module.types}/>
        </TabItem>
        {:else}
          <TabItem title={module.name}>
            <ImageUpload endpoint="{env.PUBLIC_BACKEND_BASE_URL}/modules/input/{module.name}", acceptedFileTypes={module.types}/>
        </TabItem>
        {/if}
      {/each}
    </Tabs>
</div>