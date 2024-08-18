#include "Unity.h"

// Define a structure to represent an enemy entity
struct enemy_t
{
    void *object; // Pointer to the enemy object
    Vector3 location; // 3D location of the enemy in the game world
    Vector3 worldtoscreen; // Screen coordinates of the enemy (used for rendering)
    bool enemy; // Flag to indicate if this object is an enemy
    void *transform; // Pointer to the transform component of the enemy (used for getting position)
    void *cam; // Pointer to the camera (used for world-to-screen calculations)
};

// Define the EntityManager class to manage enemies
class EntityManager
{
public:
    std::vector<enemy_t *> enemies; // Vector to store pointers to enemy_t objects

    // Method to add an enemy to the enemies vector
    void addEnemy(void *enemyPlayer)
    {
        if (!enemyPlayer) // If the enemyPlayer pointer is null, return
            return;
        if (isEnemyPresent(enemyPlayer)) // If the enemy is already present, return
            return;
        if (isCharacterDead(enemyPlayer)) // If the enemy is dead, return
            return;

        enemy_t *newEnemy = new enemy_t(); // Create a new enemy_t object
        newEnemy->object = enemyPlayer; // Assign the enemyPlayer pointer to the object field
        enemies.push_back(newEnemy); // Add the new enemy to the vector
    }

    // Method to check if an enemy is already present in the enemies vector
    bool isEnemyPresent(void *enemyObject)
    {
        for (auto &enemy : enemies) // Iterate through the enemies vector
        {
            if (enemy->object == enemyObject) // If the enemy object matches, return true
                return true;
        }
        return false; // If no match is found, return false
    }

    // Method to check if a character (player or enemy) is dead
    bool isCharacterDead(void *character)
    {
        if (Player::isAlive(character)) // Use the Player class's isAlive method to check if alive
        {
            return false; // If alive, return false
        }
        else
        {
            return true; // If dead, return true
        }
    }

    // Method to clear all enemies from the enemies vector
    void clearAll()
    {
        for (auto &enemy : enemies) // Iterate through the enemies vector
        {
            delete enemy; // Free memory allocated for each enemy
        }
        enemies.clear(); // Clear the vector
    }

    // Method to update the properties of all enemies
    void updateEnemies(void *myPlayer)
    {
        if (!myPlayer) // If the myPlayer pointer is null, return
            return;
        void *mycam = Unity::getAllCameras(0); // Get the camera used in the game [Usually the main is in index 0]

        Vector3 myLocation = Unity::getPositionInjected(Unity::getTransform(myPlayer)); // Get the player's location

        for (int i = 0; i < enemies.size(); ++i) // Iterate through the enemies vector
        {
            enemy_t *current = enemies[i]; // Get the current enemy

            if (!current->object) // If the enemy object pointer is null
            {
                enemies.erase(enemies.begin() + i); // Remove invalid enemy from the list
                delete current; // Free memory
                continue;
            }

            if (isCharacterDead(current->object)) // If the enemy is dead
            {
                enemies.erase(enemies.begin() + i); // Remove dead enemy from the list
                delete current; // Free memory
                continue;
            }

            if (mycam != NULL) // If the camera pointer is valid
            {
                current->transform = Unity::getTransform(current->object); // Get the enemy's transform
                current->location = Unity::getPositionInjected(current->transform); // Get the enemy's location
                if (current->location != Vector3(0, 0, 0)) // If the location is valid
                {
                    Vector3 orig = current->location; // Copy the location

                    current->worldtoscreen = Unity::getWorldToViewportPoint_Injected(mycam, orig, 2); // Convert world coordinates to screen coordinates
                    current->enemy = true; // Set the enemy flag to true
                    current->cam = mycam; // Store the camera pointer
                }
            }
        }
    }

    // Method to get a reference to the enemies vector
    std::vector<enemy_t *> &getAllEnemies()
    {
        return enemies; // Return the reference
    }
};
