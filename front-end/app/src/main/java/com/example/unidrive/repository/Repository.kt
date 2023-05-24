package com.example.unidrive.repository

import com.example.unidrive.api.RetrofitInstance
import com.example.unidrive.models.Profile

class Repository {

    suspend fun getProfile(): Profile {
        return RetrofitInstance.api.getProfile()

    }
}