<script lang="ts">
    import { stringify } from 'postcss';
    import { onMount, afterUpdate } from 'svelte';

    // Message type definition
    type Message = {
        sender: string;
        text: string;
        reference?: Referenz[];
    };

    type Referenz = {
        id: number;
        title: string;
    }

    // Initial conversation state
    let conversation: Message[] = [
        {
            sender: "KI-Assistent",
            text: "Hallo, wie kann ich Ihnen helfen?",

        },
        {
            sender: "Sie",
            text: "Wie funktioniert das hier?"
        },
        {
            sender: "KI-Assistent",
            text: "Ah ja du musst das genau so und so machen",
            reference: [
                {
                    id: 1,
                    title: "www.google.com"
                }
            ]
        }
    ];

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
            conversation = [
                ...conversation,
                { sender: "Sie", text: newMessage.trim() }
            ];

            // Reset newMessage input
            newMessage = "";

            // fetch mock data
            fetch('src/mockup/llmChatAnswer.json')
                .then(response => response.json())
                .then(json => {
                    console.log(json);
                    conversation = [
                    ...conversation,
                    { sender: "KI-Assistent", text: json.answer.text, reference: json.answer.sources }
                ];
                })

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
                    <p class="text-gray-800 mt-1">{message.text}</p>
                </div>
            {/if}

            {#if message.sender === "KI-Assistent"}
                <div class="bg-orange-100 p-3 mb-4 rounded-lg shadow">
                    <div class="flex items-center mb-2">
                        <span class="font-medium text-orange-700">{message.sender}</span>
                    </div>
                    <p class="text-gray-700 whitespace-pre-line">{message.text}</p>

                    {#if message.reference && message.reference.length > 0}
    
                        <!-- horizontal line -->
                        <div class="border-t border-gray-300 my-2"></div>
                        <div class="mt-2">
                            <span class="text-gray-700">Referenzen:</span>
                            {#each message.reference as ref}
                                <br>
                                [{ref.id}] <a href="https://{ref.title}" target="_blank" class="text-blue-500 underline">
                                    {ref.title}
                                </a>
                            {/each}
                        </div>
                    {/if}
                </div>
            {/if}
        {/each}
    </div>

    <div class="input-container p-4 flex items-center">
        <input
            type="text"
            bind:value={newMessage}
            class="flex-grow p-2 border border-gray-300 rounded-lg"
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
