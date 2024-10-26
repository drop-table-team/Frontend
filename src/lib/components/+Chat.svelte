<script lang="ts">
    import { onMount, afterUpdate } from 'svelte';

    // Message type definition
    type Message = {
        sender: string;
        text: string;
        reference?: string[];
    };

    // Initial conversation state
    let conversation: Message[] = [
        {
            sender: "Sie",
            text: "Hallo, wie kann ich Ihnen helfen?"
        },
        {
            sender: "KI-Assistent",
            text: "Hallo, ich bin der KI-Assistent. Wie kann ich Ihnen helfen?"
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

            // Simulate a response from KI-Assistent
            setTimeout(() => {
                conversation = [
                    ...conversation,
                    { sender: "KI-Assistent", text: "Ich habe Ihre Nachricht erhalten." }
                ];
            }, 500);
        }
    }
</script>

<style>
    .messages-container {
        max-height: 70vh;
        overflow-y: scroll;
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
                <div class="bg-white p-3 mb-4 rounded-lg shadow">
                    <div class="flex items-center mb-2">
                        <span class="font-medium text-gray-700">{message.sender}</span>
                    </div>
                    <p class="text-gray-700 whitespace-pre-line">{message.text}</p>
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
            class="ml-2 p-2 bg-blue-500 text-white rounded-lg"
        >
            Senden
        </button>
    </div>
</div>
