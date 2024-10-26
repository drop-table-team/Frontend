<script>
    import { Tabs, TabItem } from 'flowbite-svelte';
    import TagSearch from '$lib/components/+TagSearch.svelte';
</script>
  
<div class="p-4 max-w-xl mx-auto">
  <Tabs tabStyle="full" defaultClass="flex rounded-lg divide-x rtl:divide-x-reverse divide-gray-200 shadow dark:divide-gray-700">
    <TabItem open class="w-full">
        <span slot="title">Tags-Suche</span>
        <TagSearch />
    </TabItem>
    <TabItem class="w-full">
      <span slot="title">Dashboard</span>
      <p class="text-sm text-gray-500 dark:text-gray-400">
        <b>Dashboard:</b>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
      </p>
    </TabItem>
  </Tabs>
</div>

  