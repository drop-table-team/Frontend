<script>
    import Filemock from '$lib/components/+Filemock.svelte';
    import Textmock from '$lib/components/+Textmock.svelte';
    import { Alert } from 'flowbite-svelte';
    import { Tabs, TabItem } from 'flowbite-svelte';
    let uploadModules = [
        {name: 'Einfacher Upload', component: Filemock},
        {name: 'Dokumente', component: Filemock},
        {name: 'Bilder', component: Filemock},
        {name: 'Audio', component: Filemock},
        {name: 'Text', component: Textmock},
    ];
</script>
  
<div class="p-8">
          <Tabs>
            {#each uploadModules as module}
              <TabItem open title={module.name}>
                <!--<p class="text-sm text-gray-500 dark:text-gray-400">-->
                        <module.component />
                <!--</p>-->
              </TabItem>
            {/each}
          </Tabs>
</div>