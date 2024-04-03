import socket

def main():
    # Créer un socket TCP/IP
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        # Se connecter au serveur sur le port 4444
        client_socket.connect(('localhost', 4444))

        # Recevoir le message de bienvenue du serveur
        welcome_msg = client_socket.recv(1024)
        print("Message du serveur :", welcome_msg.decode('utf-8'))

        # Envoyer des données au serveur
        message = input("Entrez un message à envoyer au serveur : ")
        client_socket.send(message.encode('utf-8'))

        # Attendre la réponse du serveur et l'afficher
        response = client_socket.recv(1024)
        print("Réponse du serveur :", response.decode('utf-8'))

    except ConnectionRefusedError:
        print("La connexion au serveur a été refusée.")

    finally:
        # Fermer la connexion avec le serveur
        client_socket.close()

if __name__ == "__main__":
    main()
