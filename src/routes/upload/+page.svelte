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
        <TabItem open title={module.name}>
          <!--<p class="text-sm text-gray-500 dark:text-gray-400">-->
                  <ImageUpload endpoint="{env.PUBLIC_BACKEND_BASE_URL}/modules/input/{module.name}", acceptedFileTypes={module.types}/>
          <!--</p>-->
        </TabItem>
      {/each}
    </Tabs>
</div>