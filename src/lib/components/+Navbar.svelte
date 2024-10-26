<script>
    import { Navbar, NavBrand, NavLi, NavUl, NavHamburger } from 'flowbite-svelte';

    let links = [
        { name: 'Home', href: '/' },
        { name: 'About', href: '/about' },
        { name: 'Navbar', href: '/docs/components/navbar' },
        { name: 'Pricing', href: '/pricing' },
        { name: 'Contact', href: '/contact' },
    ];
</script>
<Navbar>
    <NavBrand href="/">
      <img src="/images/flowbite-svelte-icon-logo.svg" class="me-3 h-6 sm:h-9" alt="Flowbite Logo" />
      <span class="self-center whitespace-nowrap text-xl font-semibold dark:text-white">Flowbite</span>
    </NavBrand>
    <NavHamburger  />
    <NavUl >
      {#each links as link}
        <NavLi href={link.href}>{link.name}</NavLi>
      {/each}
    </NavUl>
</Navbar>