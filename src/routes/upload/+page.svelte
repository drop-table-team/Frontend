<script>
    import { env } from '$env/dynamic/public'
    import Filemock from '$lib/components/+Filemock.svelte';
    import Textmock from '$lib/components/+Textmock.svelte';
    import ImageUpload from '$lib/components/+ImageUpload.svelte';
    import { Tabs, TabItem } from 'flowbite-svelte';
    import { onMount } from 'svelte';
    let uploadModules = [
        {name: 'Einfacher Upload', component: Filemock},
        {name: 'Dokumente', component: Filemock},
        {name: 'Bild', component: ImageUpload, endpoint: {address: "https://test.tets"}},
        {name: 'Audio', component: Filemock},
        {name: 'Text', component: Textmock},
    ];
    onMount(async() => {
      const res = await fetch(`${env.PUBLIC_BACKEND_BASE_URL}/modules`);
		  //photos = await res.json();
    });
</script>
  
<div class="p-8 max-w-7xl mx-auto">
    <Tabs>
      {#each uploadModules as module}
        <TabItem open title={module.name}>
          <!--<p class="text-sm text-gray-500 dark:text-gray-400">-->
                  <module.component endpoint={module.endpoint}/>
          <!--</p>-->
        </TabItem>
      {/each}
    </Tabs>
</div>