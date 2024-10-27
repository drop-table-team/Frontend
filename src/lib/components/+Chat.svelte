<script lang="ts">
    import { Input, Popover } from 'flowbite-svelte';
    import { SalePercentOutline } from 'flowbite-svelte-icons';
    import { stringify } from 'postcss';
    import { onMount, afterUpdate } from 'svelte';
    import { env } from '$env/dynamic/public'
    
    // Message type definition
    type Message = {
        messageId: number;
        sender: string;
        response: string;
        reference?: Referenz[];
    };

    type Referenz = {
        id: number;
        title: string;
        snippet: string;
    }

    // Initial conversation state
    let conversation: Message[] = [
        {
            messageId: 0,
            sender: "KI-Assistent",
            response: "Hallo, wie kann ich Ihnen helfen?",
        }/*,
        {
            sender: "Sie",
            response: "Wie funktioniert das hier?"
        },
        {
            sender: "KI-Assistent",
            response: "Ah ja du musst das genau so und so machen",
            reference: [
                {
                    id: 1,
                    title: "www.google.com",
                    snippet: "Das ist ein toller Link"
                },
                {
                    id: 2,
                    title: "www.example.com",
                    snippet: "Das ist ein sehr toller Link"
                }
            ]
        }*/
    ];
    console.log(env.PUBLIC_SEARCH_LLM_URL);
    // New message input
    let newMessage = "";
    let messagesContainer: HTMLElement;

    // Function to scroll to the bottom of the chat
    function scrollToBottom() {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    // Run scroll function whenever conversation changes
    afterUpdate(() => {
        scrollToBottom();
    });
    
    // Function to send a new message
    function sendMessage() {
        if (newMessage.trim()) {
        // Nachricht zur Unterhaltung hinzufügen
        conversation = [
            ...conversation,
            { messageId: conversation.length - 1, sender: "Sie", response: newMessage.trim() }
        ];

        // Parameter in URL-Encoding umwandeln
        let encodedMessage = encodeURIComponent(newMessage.trim());
        
        
        conversation.push({ messageId: conversation.length - 1, sender: "KI-Assistent", response: "Ihre Anfrage wird bearbeitet" });
        
        // GET-Request mit Nachricht als URL-Parameter senden
        fetch(`${env.PUBLIC_SEARCH_LLM_URL}/ask`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ prompt: newMessage.trim() })

            // message with anfrage wird bearbeitet
        }).then(response => response.json())
            .then(data => {
                // edit the last message
                conversation[conversation.length - 1].response = data.response;
                conversation[conversation.length - 1].reference = data.sources;
            });

        // Eingabe für neue Nachricht zurücksetzen
        newMessage = "";
    }
    }
</script>

<style>
    .messages-container {
        max-height: 70vh;
        overflow-y: auto;
    }

    .chat-container {
        display: grid;
        grid-template-rows: 1fr auto;
        height: 70vh;
    }
</style>

<div class="chat-container">
    <div bind:this={messagesContainer} class="messages p-4 messages-container">
        {#each conversation as message}
            {#if message.sender === "Sie"}
                <div class="bg-blue-100 p-3 mb-4 rounded-lg shadow">
                    <div class="flex items-center mb-2">
                        <span class="font-medium text-gray-800">{message.sender}</span>
                    </div>
                    <p class="text-gray-800 mt-1">{message.response}</p>
                </div>
            {/if}

            {#if message.sender === "KI-Assistent"}
                <div class="bg-orange-100 p-3 mb-4 rounded-lg shadow">
                    <div class="flex items-center mb-2">
                        <span class="font-medium text-orange-700">{message.sender}</span>
                    </div>
                    <p class="text-gray-700 whitespace-pre-line">{message.response}</p>

                    {#if message.reference && message.reference.length > 0}
    
                        <!-- horizontal line -->
                        <div class="border-t border-gray-300 my-2"></div>
                        <div class="mt-2">
                            <span class="text-gray-700">Referenzen:</span>
                            {#each message.reference as ref}
                                <br>
                                [{ref.id}] <a href="https://{ref.title}" target="_blank" id="popover_{ref.id}" class="text-blue-500 underline">
                                    {ref.title}
                                </a>
                                <Popover class="w-64 text-sm font-light " title="{ref.title}" triggeredBy="#popover_{ref.id}">{ref.snippet}</Popover>
                            {/each}
                        </div>
                    {/if}
                </div>
            {/if}
        {/each}
    </div>

    <div class="input-container p-4 flex items-center">
        <Input
            type="text"
            bind:value={newMessage}
            placeholder="Schreiben Sie eine Nachricht..."
            on:keypress={(e) => e.key === 'Enter' && sendMessage()}
        />
        <button
            on:click={sendMessage}
            class="ml-2 p-2 bg-orange-500 text-white rounded-lg"
        >
            Senden
        </button>
    </div>
</div>
