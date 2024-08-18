namespace offset
{

    namespace player
    {
        constexpr uint64_t update = 0x21538D4;  //Need for hook!
        constexpr uint64_t playerAlive = 0x1FCA008;  //Ofc we don't render dead players!
        constexpr uint64_t isMine = 0x1DBA744; //We also won't render ourself
        constexpr uint64_t playerOnTeam = 0x25A85F0; //We will only render enemy
    }
    namespace unityEngine
    {
        namespace transform
        {
            constexpr uint64_t get_position_injected = 0x2173308; //Aaccesses the position of a transform in the game world
            constexpr uint64_t get_localScale = 0x1F3C21C; //We'll use this to set the box width / height
        }
        namespace component
        {
            constexpr uint64_t get_transform = 0x1DED5B4; //Retrieves the transform component of a game objec
        }
    }
    namespace camera
    {
        constexpr uint64_t worldToViewPort_injected = 0x1EC2C38; //We need to convert the player coordinates to screen
        constexpr uint64_t allCameras = 0x1F40E80; //This is a monoArray, this will be used to get the main camera, very important to access worldtoviewport
    }
}