<script>
    import { Textarea, Toolbar, ToolbarGroup, ToolbarButton, Button } from 'flowbite-svelte';
    import { PaperClipOutline, MapPinAltSolid, ImageOutline, CodeOutline, FaceGrinOutline, PaperPlaneOutline } from 'flowbite-svelte-icons';
    function textSubmit() {
      console.log('Text submitted');
    }
</script>
  
  <form>
    <label for="editor" class="sr-only">Publish post</label>
    <Textarea id="editor" rows="8" class="mb-4" placeholder="Write a comment">
      <Toolbar slot="header" embedded>
        <ToolbarGroup>
          <ToolbarButton name="Attach file"><PaperClipOutline class="w-6 h-6 rotate-45" /></ToolbarButton>
          <ToolbarButton name="Embed map"><MapPinAltSolid class="w-6 h-6" /></ToolbarButton>
          <ToolbarButton name="Upload image"><ImageOutline class="w-6 h-6" /></ToolbarButton>
        </ToolbarGroup>
        <ToolbarGroup>
          <ToolbarButton name="Format code"><CodeOutline class="w-6 h-6" /></ToolbarButton>
          <ToolbarButton name="Add emoji"><FaceGrinOutline class="w-6 h-6" /></ToolbarButton>
        </ToolbarGroup>
        <ToolbarButton name="send" slot="end"><PaperPlaneOutline class="w-6 h-6 rotate-45" /></ToolbarButton>
      </Toolbar>
    </Textarea>
    <Button on:click={textSubmit}>Text Absenden</Button>
  </form>