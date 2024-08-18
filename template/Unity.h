#ifndef UNITY_H
#define UNITY_H

// Define the monoArray struct template to represent a dynamic array used in Unity
template <typename T>
struct monoArray {
    void* klass; // Pointer to the class information
    void* monitor; // Synchronization monitor
    void* bounds; // Array bounds (used for multi-dimensional arrays)
    int max_length; // Maximum length of the array
    T vector[0]; // Flexible array member (actual array elements follow this structure in memory)

    // Method to get the pointer to the array elements
    T* getPointer() {
        return vector;
    }

    // Method to get the size of the array
    int size() const {
        return max_length;
    }
};

// Define the Unity class to encapsulate Unity-specific functionality
class Unity {
public:
    // Static methods to interact with Unity's API
    static void* getTransform(void *Player); // Get the transform component of a player
    static Vector3 getPositionInjected(void *PlayerTransform); // Get the position of a transform component
    static Vector3 getWorldToViewportPoint_Injected(void *camera, Vector3 &position, int eye); // Convert world coordinates to viewport coordinates
    static void* getAllCameras(int index); // Get a specific camera by index
    static Vector3 get_localScale(void *PlayerTransform); // Get the local scale of a transform component
};

// Typedefs for function pointers to Unity's internal functions
typedef void* (*onTransformCall)(void *); // Typedef for function pointer to get_transform
typedef Vector3 (*onPositionInjectedCall)(void *); // Typedef for function pointer to get_position_injected
typedef void (*getWorldToViewportPoint_InjectedCall)(void *, Vector3&, int, Vector3&); // Typedef for function pointer to worldToViewportPoint_Injected
typedef monoArray<void*>* (*getAllCamerasCall)(void *, void*); // Typedef for function pointer to allCameras
typedef Vector3 (*getLocalScaleCall)(void *); // Typedef for function pointer to get_localScale

// Implementation of the static methods in the Unity class

// Method to convert world coordinates to viewport coordinates
Vector3 Unity::getWorldToViewportPoint_Injected(void *camera, Vector3 &position, int eye) {
    // Get the function pointer to the internal worldToViewportPoint_Injected method
    static getWorldToViewportPoint_InjectedCall func = (getWorldToViewportPoint_InjectedCall)getRealOffset(offset::camera::worldToViewPort_injected); 
    Vector3 result; // Variable to hold the result
    func(camera, position, eye, result); // Call the function with the camera, position, and eye parameters
    return result; // Return the result
}

// Method to get the transform component of a player
void* Unity::getTransform(void *Player) {
    // Get the function pointer to the internal get_transform method
    static onTransformCall func = (onTransformCall)getRealOffset(offset::unityEngine::component::get_transform);
    return func(Player); // Call the function and return the transform component
}

// Method to get the position of a transform component
Vector3 Unity::getPositionInjected(void *PlayerTransform) {
    // Get the function pointer to the internal get_position_injected method
    static onPositionInjectedCall func = (onPositionInjectedCall)getRealOffset(offset::unityEngine::transform::get_position_injected);
    return func(PlayerTransform); // Call the function and return the position
}

// Method to get all cameras and return the camera at the specified index
void* Unity::getAllCameras(int index) {
    // Get the function pointer to the internal allCameras method
    static getAllCamerasCall func = (getAllCamerasCall)getRealOffset(offset::camera::allCameras); 
    monoArray<void*>* cameras = func(NULL, NULL); // Call the function to get the array of cameras
    if (index >= 0 && index < cameras->size()) { // Check if the index is within bounds
        void** array = cameras->getPointer(); // Get the pointer to the array elements
        return array[index]; // Return the camera at the specified index
    }
    return nullptr; // Return nullptr if the index is out of range
}

// Method to get the local scale of a transform component
Vector3 Unity::get_localScale(void *PlayerTransform) {
    // Get the function pointer to the internal get_localScale method
    static getLocalScaleCall func = (getLocalScaleCall)getRealOffset(offset::unityEngine::transform::get_localScale);
    return func(PlayerTransform); // Call the function and return the local scale
}

#endif // UNITY_H