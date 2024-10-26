<script>
    import { Tabs, TabItem } from 'flowbite-svelte';
    import TagSearch from '$lib/components/+TagSearch.svelte';
    import Chat from '$lib/components/+Chat.svelte';
</script>
  
<div class="p-4 max-w-xl mx-auto">
  <Tabs tabStyle="full" defaultClass="flex rounded-lg divide-x rtl:divide-x-reverse divide-gray-200 shadow dark:divide-gray-700">
    <TabItem open class="w-full">
        <span slot="title">Tags-Suche</span>
        <TagSearch />
    </TabItem>
    <TabItem class="w-full">
      <span slot="title">KI-Chatfunktion</span>
      <Chat />
    </TabItem>
  </Tabs>
</div>

  