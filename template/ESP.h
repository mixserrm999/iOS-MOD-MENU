#ifndef ESP_H
#define ESP_H

// Define the ESP class
class ESP
{
    public:
    // Method to render ESP elements
    void render(EntityManager &entityManager)
    {
        // Get the width and height of the screen
        float screenWidth = [UIApplication sharedApplication].keyWindow.frame.size.width;
        float screenHeight = [UIApplication sharedApplication].keyWindow.frame.size.width;

        // Get all enemies from the entity manager
        auto & enemies = entityManager.getAllEnemies();

        // Loop through all enemies
        for (auto & enemy : enemies)
        {
            if (enemy->worldtoscreen.Z > 0) // Check if the enemy is in front of the camera
            {
                // Get the player's scale
                Vector3 playerScale = Unity::get_localScale(enemy->transform);

                // Calculate the vertices of the bounding box
                Vector3 boxVertices[8];
                float width = playerScale.X / 2.0f;
                float height = playerScale.Y + 0.5f;
                float depth = playerScale.Z / 2.0f;
                float yOffset = 1.3f; // Adjust this value as needed
                Vector3 center = enemy->location + Vector3(0, -yOffset, 0);

                // Define 2D vertices of the bounding box
                Vector3 boxVertices2d[8];
                boxVertices2d[0] = center + Vector3(-width, 0, 0);      // Bottom-left
                boxVertices2d[1] = center + Vector3(width, 0, 0);       // Bottom-right
                boxVertices2d[2] = center + Vector3(width, height, 0);  // Top-right
                boxVertices2d[3] = center + Vector3(-width, height, 0); // Top-left

                ImVec2 screenVertices2d[4]; // Screen coordinates of the 2D box
                bool isVisible = true;

                // Project 2D vertices to screen space
                for (int i = 0; i < 4; ++i)
                {
                    Vector3 screenPos = Unity::getWorldToViewportPoint_Injected(enemy->cam, boxVertices2d[i], 2); // Convert world coordinates to viewport coordinates
                    if (screenPos.Z > 0)
                    {
                        screenVertices2d[i] = ImVec2(screenPos.X * screenWidth, (1.0f - screenPos.Y) * screenHeight); // Map coordinates to screen space
                    }
                    else
                    {
                        isVisible = false; // If any vertex is behind the camera, set isVisible to false
                        break;
                    }
                }

                if (!isVisible)
                    continue; // Skip rendering if the bounding box is not visible

                // Render the ESP box
                ImDrawList* drawList = ImGui::GetOverlayDrawList(); // Get the draw list for ImGui overlay

                // Draw lines for the edges of the bounding box
                drawList->AddLine(screenVertices2d[0], screenVertices2d[1], IM_COL32(255, 255, 255, 255)); // Bottom edge
                drawList->AddLine(screenVertices2d[1], screenVertices2d[2], IM_COL32(255, 255, 255, 255)); // Right edge
                drawList->AddLine(screenVertices2d[2], screenVertices2d[3], IM_COL32(255, 255, 255, 255)); // Top edge
                drawList->AddLine(screenVertices2d[3], screenVertices2d[0], IM_COL32(255, 255, 255, 255)); // Left edge

            }
        }
    }
};

#endif // ESP_H