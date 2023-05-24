package com.example.unidrive.api

import com.example.unidrive.models.Profile
import retrofit2.http.GET

interface SimpleApi {

    @GET("profile/1")
    suspend fun getProfile(): Profile
}