<script>
    import { Navbar, NavBrand, NavLi, NavUl, NavHamburger } from 'flowbite-svelte';

    let links = [
        { name: 'Wissen finden', href: '/find' },
        { name: 'Wissen hinterlegen', href: '/upload' },
        { name: 'Impressum', href: '/impressum' }
    ];
</script>
<Navbar>
    <NavBrand href="/">
      <img src="Logo.png" class="me-3 h-6 sm:h-9" alt="Flowbite Logo" />
      <span class="self-center whitespace-nowrap text-xl font-semibold dark:text-white">Knowledge Base</span>
    </NavBrand>
    <NavHamburger  />
    <NavUl >
      {#each links as link}
        <NavLi href={link.href}>{link.name}</NavLi>
      {/each}
    </NavUl>
</Navbar>