<template>
  <div
    class="min-h-screen bg-slate-50 text-slate-900 font-sans antialiased selection:bg-indigo-500 selection:text-white"
  >
    <!-- Top Navigation Header -->
    <header
      class="bg-white border-b border-slate-200 sticky top-0 z-30 shadow-xs"
    >
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <!-- Logo & Brand -->
          <div class="flex items-center gap-3">
            <div
              class="w-10 h-10 rounded-xl bg-gradient-to-tr from-indigo-600 to-violet-500 flex items-center justify-center text-white shadow-md shadow-indigo-200"
            >
              <svg
                class="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M12 14l9-5-9-5-9 5 9 5z"
                />
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"
                />
              </svg>
            </div>
            <div>
              <div class="flex items-center gap-2">
                <h1 class="text-lg font-bold text-slate-900 tracking-tight">
                  EduManage
                </h1>
                <span
                  class="text-[10px] font-semibold bg-indigo-50 text-indigo-700 px-2 py-0.5 rounded-full border border-indigo-200 uppercase tracking-wider"
                  >Nuxt 3 + MySQL</span
                >
              </div>
              <p class="text-xs text-slate-500 hidden sm:block">
                Full-Stack Student Management System
              </p>
            </div>
          </div>

          <!-- Header Actions -->
          <div class="flex items-center gap-3">
            <template v-if="currentUser">
              <button
                @click="seedDatabase"
                :disabled="isSeeding"
                title="Seed 6 demo students into MySQL"
                class="hidden sm:inline-flex items-center gap-1.5 px-3 py-2 text-xs font-semibold text-slate-700 bg-slate-100 hover:bg-slate-200 rounded-xl transition border border-slate-200 disabled:opacity-50"
              >
                <svg
                  v-if="isSeeding"
                  class="animate-spin w-3.5 h-3.5 text-slate-600"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <circle
                    class="opacity-25"
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="currentColor"
                    stroke-width="4"
                  ></circle>
                  <path
                    class="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8v8H4z"
                  ></path>
                </svg>
                <svg
                  v-else
                  class="w-3.5 h-3.5 text-slate-600"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"
                  />
                </svg>
                <span>{{ isSeeding ? "Seeding..." : "Seed Sample Data" }}</span>
              </button>

              <button
                @click="openCreateModal"
                class="inline-flex items-center gap-2 px-3.5 py-2 text-xs sm:text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-700 rounded-xl shadow-sm shadow-indigo-200 transition"
              >
                <svg
                  class="w-4 h-4"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M12 4v16m8-8H4"
                  />
                </svg>
                <span>Add Student</span>
              </button>

              <!-- Logged-in User Profile -->
              <div class="hidden md:flex items-center gap-2 pl-3 border-l border-slate-200">
                <div class="w-8 h-8 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center uppercase">
                  {{ currentUser.name ? currentUser.name[0] : 'U' }}
                </div>
                <div class="text-left text-xs leading-tight">
                  <div class="font-bold text-slate-800">{{ currentUser.name }}</div>
                  <span class="inline-block px-1.5 py-0.2 rounded bg-indigo-50 text-indigo-600 text-[10px] font-semibold uppercase">
                    {{ currentUser.role || 'Admin' }}
                  </span>
                </div>
              </div>

              <!-- Sign Out Button -->
              <button
                @click="handleLogout"
                title="Sign Out"
                class="p-2 text-slate-500 hover:text-rose-600 hover:bg-rose-50 rounded-xl transition border border-slate-200 flex items-center gap-1.5 text-xs font-semibold"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
                <span class="hidden sm:inline">Logout</span>
              </button>
            </template>
            <template v-else>
              <span class="text-xs font-medium text-slate-500">Please sign in to access records</span>
            </template>
          </div>
        </div>
      </div>
    </header>

    <!-- Loading Session Screen -->
    <div v-if="isCheckingAuth" class="min-h-[70vh] flex flex-col items-center justify-center">
      <div class="w-12 h-12 rounded-full border-4 border-indigo-200 border-t-indigo-600 animate-spin"></div>
      <p class="text-xs font-semibold text-slate-500 mt-4">Checking authentication session...</p>
    </div>

    <!-- Login / Signup Screen if Not Authenticated -->
    <AuthCard v-else-if="!currentUser" @auth-success="onAuthSuccess" />

    <!-- Main Content Container (Authenticated) -->
    <main v-else class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-6">
      <!-- Database Connection Error Banner -->
      <div
        v-if="dbError"
        class="p-5 bg-rose-50 border border-rose-200 rounded-2xl text-rose-900 shadow-xs"
      >
        <div class="flex items-start gap-3">
          <div class="p-2 bg-rose-100 text-rose-600 rounded-xl">
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </div>
          <div class="flex-1">
            <h3 class="text-sm font-bold">MySQL Connection Error</h3>
            <p class="text-xs text-rose-700 mt-1">{{ dbError }}</p>
            <div
              class="mt-3 text-xs bg-white/70 p-3 rounded-lg border border-rose-200 text-slate-800"
            >
              <strong>Quick Fix:</strong> Check your
              <code class="bg-rose-100 px-1 py-0.5 rounded text-rose-800"
                >.env</code
              >
              file (host: <code class="text-rose-800">127.0.0.1</code>, user:
              <code class="text-rose-800">root</code>, password:
              <code class="text-rose-800">YOUR_MYSQL_PASSWORD</code>) and ensure
              MySQL Server service is running.
            </div>
            <button
              @click="fetchAll"
              class="mt-3 inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold bg-rose-600 text-white rounded-lg hover:bg-rose-700 transition"
            >
              Retry Connection
            </button>
          </div>
        </div>
      </div>

      <!-- Metric Stats Overview -->
      <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
        <StatCard
          title="Total Students"
          :value="stats.total"
          subtitle="Enrolled records"
          badge="All"
          icon-bg-class="bg-indigo-50 text-indigo-600"
          badge-class="bg-indigo-50 text-indigo-700"
        >
          <template #icon>
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
              />
            </svg>
          </template>
        </StatCard>

        <StatCard
          title="Active Students"
          :value="stats.active"
          subtitle="Currently attending"
          badge="Active"
          icon-bg-class="bg-emerald-50 text-emerald-600"
          badge-class="bg-emerald-50 text-emerald-700"
        >
          <template #icon>
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </template>
        </StatCard>

        <StatCard
          title="Graduated"
          :value="stats.graduated"
          subtitle="Alumni count"
          badge="Completed"
          icon-bg-class="bg-purple-50 text-purple-600"
          badge-class="bg-purple-50 text-purple-700"
        >
          <template #icon>
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
              />
            </svg>
          </template>
        </StatCard>

        <StatCard
          title="Average GPA"
          :value="stats.avgGpa"
          subtitle="Overall performance"
          badge="Academic"
          icon-bg-class="bg-amber-50 text-amber-600"
          badge-class="bg-amber-50 text-amber-700"
        >
          <template #icon>
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"
              />
            </svg>
          </template>
        </StatCard>

        <StatCard
          title="Departments"
          :value="stats.coursesCount"
          subtitle="Distinct programs"
          badge="Majors"
          icon-bg-class="bg-cyan-50 text-cyan-600"
          badge-class="bg-cyan-50 text-cyan-700"
        >
          <template #icon>
            <svg
              class="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"
              />
            </svg>
          </template>
        </StatCard>
      </div>

      <!-- Filters & Search Toolbar -->
      <div
        class="bg-white p-4 rounded-2xl border border-slate-200 shadow-xs space-y-3"
      >
        <div class="grid grid-cols-1 sm:grid-cols-12 gap-3">
          <!-- Search Input -->
          <div class="sm:col-span-5 relative">
            <div
              class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400"
            >
              <svg
                class="w-4 h-4"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                />
              </svg>
            </div>
            <input
              v-model="filters.search"
              type="text"
              placeholder="Search by name, ID, email, or phone..."
              class="w-full pl-9 pr-3 py-2 text-sm rounded-xl border border-slate-300 focus:outline-hidden focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 bg-white"
            />
          </div>

          <!-- Course Filter -->
          <div class="sm:col-span-3">
            <select
              v-model="filters.course"
              class="w-full py-2 px-3 text-sm rounded-xl border border-slate-300 bg-white focus:outline-hidden focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            >
              <option value="All">All Courses</option>
              <option value="Computer Science">Computer Science</option>
              <option value="Data Science">Data Science</option>
              <option value="Information Technology">
                Information Technology
              </option>
              <option value="Electrical Engineering">
                Electrical Engineering
              </option>
              <option value="Mechanical Engineering">
                Mechanical Engineering
              </option>
              <option value="Business Administration">
                Business Administration
              </option>
              <option value="Civil Engineering">Civil Engineering</option>
              <option value="Cyber Security">Cyber Security</option>
            </select>
          </div>

          <!-- Status Filter -->
          <div class="sm:col-span-2">
            <select
              v-model="filters.status"
              class="w-full py-2 px-3 text-sm rounded-xl border border-slate-300 bg-white focus:outline-hidden focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            >
              <option value="All">All Statuses</option>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
              <option value="Graduated">Graduated</option>
              <option value="Suspended">Suspended</option>
            </select>
          </div>

          <!-- Sort Column -->
          <div class="sm:col-span-2 flex items-center gap-2">
            <select
              v-model="filters.sortBy"
              class="w-full py-2 px-3 text-sm rounded-xl border border-slate-300 bg-white focus:outline-hidden focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            >
              <option value="id">Latest Added</option>
              <option value="first_name">Name (A-Z)</option>
              <option value="gpa">GPA</option>
              <option value="student_id">Student ID</option>
              <option value="enrollment_date">Enrollment</option>
            </select>

            <button
              @click="toggleSortOrder"
              :title="
                filters.order === 'ASC'
                  ? 'Ascending (click for Descending)'
                  : 'Descending (click for Ascending)'
              "
              class="p-2 border border-slate-300 rounded-xl hover:bg-slate-50 transition text-slate-600"
            >
              <svg
                v-if="filters.order === 'ASC'"
                class="w-4 h-4"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12"
                />
              </svg>
              <svg
                v-else
                class="w-4 h-4"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M3 4h13M3 8h9m-9 4h9m5-4v12m0 0l-4-4m4 4l4-4"
                />
              </svg>
            </button>
          </div>
        </div>

        <!-- Filter helper row -->
        <div
          class="flex items-center justify-between text-xs text-slate-500 pt-1 border-t border-slate-100"
        >
          <div>
            Showing
            <strong class="text-slate-900">{{ students.length }}</strong>
            students
            <span v-if="hasActiveFilters" class="text-indigo-600 font-medium">
              (filtered)</span
            >
          </div>
          <button
            v-if="hasActiveFilters"
            @click="resetFilters"
            class="text-indigo-600 hover:text-indigo-800 font-medium hover:underline flex items-center gap-1"
          >
            <span>Reset Filters</span>
          </button>
        </div>
      </div>

      <!-- Students Table Card -->
      <div
        class="bg-white rounded-2xl border border-slate-200 shadow-xs overflow-hidden"
      >
        <!-- Loading State -->
        <div v-if="isLoading" class="p-16 text-center">
          <div
            class="inline-flex items-center justify-center p-4 rounded-full bg-indigo-50 text-indigo-600 mb-3 animate-pulse"
          >
            <svg class="w-8 h-8 animate-spin" fill="none" viewBox="0 0 24 24">
              <circle
                class="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                stroke-width="4"
              ></circle>
              <path
                class="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8v8H4z"
              ></path>
            </svg>
          </div>
          <p class="text-sm font-semibold text-slate-700">
            Connecting to MySQL and loading student records...
          </p>
        </div>

        <!-- Empty State -->
        <div v-else-if="students.length === 0" class="p-16 text-center">
          <div
            class="w-16 h-16 mx-auto rounded-full bg-slate-100 flex items-center justify-center text-slate-400 mb-4"
          >
            <svg
              class="w-8 h-8"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"
              />
            </svg>
          </div>
          <h3 class="text-base font-bold text-slate-800">
            No Student Records Found
          </h3>
          <p class="text-xs text-slate-500 max-w-sm mx-auto mt-1 mb-5">
            {{
              hasActiveFilters
                ? "No students matched your search criteria. Try resetting filters."
                : "Your MySQL student table is currently empty. Add your first student or click below to populate sample records."
            }}
          </p>
          <div class="flex items-center justify-center gap-3">
            <button
              v-if="hasActiveFilters"
              @click="resetFilters"
              class="px-4 py-2 text-xs font-semibold text-slate-700 bg-slate-100 hover:bg-slate-200 rounded-xl transition"
            >
              Clear Filters
            </button>
            <button
              v-else
              @click="seedDatabase"
              :disabled="isSeeding"
              class="px-4 py-2 text-xs font-semibold text-indigo-700 bg-indigo-50 hover:bg-indigo-100 border border-indigo-200 rounded-xl transition"
            >
              Seed Sample Students
            </button>
            <button
              @click="openCreateModal"
              class="px-4 py-2 text-xs font-semibold text-white bg-indigo-600 hover:bg-indigo-700 rounded-xl shadow-xs transition"
            >
              + Add New Student
            </button>
          </div>
        </div>

        <!-- Table View -->
        <div v-else class="overflow-x-auto">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr
                class="border-b border-slate-200 bg-slate-50/75 text-[11px] font-bold text-slate-500 uppercase tracking-wider"
              >
                <th class="py-3.5 pl-6 pr-3">Student</th>
                <th class="py-3.5 px-3">Contact</th>
                <th class="py-3.5 px-3">Course & Year</th>
                <th class="py-3.5 px-3 text-center">GPA</th>
                <th class="py-3.5 px-3 text-center">Status</th>
                <th class="py-3.5 px-3">Enrolled</th>
                <th class="py-3.5 pr-6 pl-3 text-right">Actions</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100 text-sm">
              <tr
                v-for="s in students"
                :key="s.id"
                class="hover:bg-slate-50/80 transition group"
              >
                <!-- Student Name & Avatar -->
                <td class="py-4 pl-6 pr-3">
                  <div class="flex items-center gap-3">
                    <div
                      class="w-10 h-10 rounded-full flex items-center justify-center font-bold text-xs uppercase flex-shrink-0"
                      :class="getAvatarColor(s.first_name)"
                    >
                      {{ s.first_name[0] }}{{ s.last_name[0] }}
                    </div>
                    <div>
                      <div
                        class="font-semibold text-slate-900 group-hover:text-indigo-600 transition"
                      >
                        {{ s.first_name }} {{ s.last_name }}
                      </div>
                      <div
                        class="text-xs text-slate-500 font-mono flex items-center gap-1.5 mt-0.5"
                      >
                        <span
                          class="bg-slate-100 text-slate-600 px-1.5 py-0.2 rounded border border-slate-200 text-[10px]"
                          >{{ s.student_id }}</span
                        >
                      </div>
                    </div>
                  </div>
                </td>

                <!-- Contact Info -->
                <td class="py-4 px-3">
                  <div class="text-slate-800 text-xs">{{ s.email }}</div>
                  <div class="text-slate-400 text-xs mt-0.5">
                    {{ s.phone || "—" }}
                  </div>
                </td>

                <!-- Course & Year -->
                <td class="py-4 px-3">
                  <div class="font-medium text-slate-800 text-xs">
                    {{ s.course }}
                  </div>
                  <div class="text-slate-500 text-[11px] mt-0.5">
                    {{ s.year_level }}
                  </div>
                </td>

                <!-- GPA -->
                <td class="py-4 px-3 text-center">
                  <span
                    class="inline-block px-2 py-0.5 text-xs font-bold rounded-lg font-mono"
                    :class="{
                      'bg-emerald-50 text-emerald-700 border border-emerald-200':
                        Number(s.gpa) >= 3.5,
                      'bg-blue-50 text-blue-700 border border-blue-200':
                        Number(s.gpa) >= 3.0 && Number(s.gpa) < 3.5,
                      'bg-amber-50 text-amber-700 border border-amber-200':
                        Number(s.gpa) < 3.0,
                    }"
                  >
                    {{ Number(s.gpa).toFixed(2) }}
                  </span>
                </td>

                <!-- Status Badge -->
                <td class="py-4 px-3 text-center">
                  <span
                    class="inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-semibold rounded-full"
                    :class="{
                      'bg-emerald-100 text-emerald-800': s.status === 'Active',
                      'bg-slate-100 text-slate-700': s.status === 'Inactive',
                      'bg-purple-100 text-purple-800': s.status === 'Graduated',
                      'bg-rose-100 text-rose-800': s.status === 'Suspended',
                    }"
                  >
                    <span
                      class="w-1.5 h-1.5 rounded-full"
                      :class="{
                        'bg-emerald-500': s.status === 'Active',
                        'bg-slate-400': s.status === 'Inactive',
                        'bg-purple-500': s.status === 'Graduated',
                        'bg-rose-500': s.status === 'Suspended',
                      }"
                    ></span>
                    {{ s.status }}
                  </span>
                </td>

                <!-- Enrollment Date -->
                <td class="py-4 px-3 text-xs text-slate-500">
                  {{ formatDate(s.enrollment_date) }}
                </td>

                <!-- Actions -->
                <td class="py-4 pr-6 pl-3 text-right">
                  <div class="flex items-center justify-end gap-1.5">
                    <button
                      @click="openEditModal(s)"
                      title="Edit student details"
                      class="p-2 text-slate-500 hover:text-indigo-600 hover:bg-indigo-50 rounded-xl transition"
                    >
                      <svg
                        class="w-4 h-4"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                        />
                      </svg>
                    </button>
                    <button
                      @click="confirmDelete(s)"
                      title="Delete student"
                      class="p-2 text-slate-500 hover:text-rose-600 hover:bg-rose-50 rounded-xl transition"
                    >
                      <svg
                        class="w-4 h-4"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                        />
                      </svg>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </main>

    <!-- Student Add / Edit Modal -->
    <StudentModal
      :is-open="isStudentModalOpen"
      :student="editingStudent"
      :is-submitting="isSaving"
      @close="isStudentModalOpen = false"
      @save="handleSaveStudent"
    />

    <!-- Delete Confirmation Modal -->
    <DeleteConfirmModal
      :is-open="isDeleteModalOpen"
      :student-name="
        deletingStudent
          ? `${deletingStudent.first_name} ${deletingStudent.last_name}`
          : ''
      "
      :student-id="deletingStudent?.student_id"
      :is-deleting="isDeleting"
      @close="isDeleteModalOpen = false"
      @confirm="handleDeleteStudent"
    />

    <!-- Toast Notifications -->
    <Toast v-model="toast" />
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, watch } from "vue";

interface Student {
  id: number;
  student_id: string;
  first_name: string;
  last_name: string;
  email: string;
  phone: string;
  course: string;
  year_level: string;
  gpa: number;
  status: "Active" | "Inactive" | "Graduated" | "Suspended";
  enrollment_date: string;
  address: string;
  created_at?: string;
  updated_at?: string;
}

const currentUser = ref<any>(null);
const isCheckingAuth = ref(true);

const students = ref<Student[]>([]);
const isLoading = ref(true);
const isSaving = ref(false);
const isDeleting = ref(false);
const isSeeding = ref(false);
const dbError = ref<string | null>(null);

// Stats
const stats = reactive({
  total: 0,
  active: 0,
  graduated: 0,
  avgGpa: "0.00",
  coursesCount: 0,
});

// Filters
const filters = reactive({
  search: "",
  course: "All",
  status: "All",
  sortBy: "id",
  order: "DESC" as "ASC" | "DESC",
});

// Modals state
const isStudentModalOpen = ref(false);
const editingStudent = ref<Student | null>(null);

const isDeleteModalOpen = ref(false);
const deletingStudent = ref<Student | null>(null);

// Toast State
const toast = ref({
  visible: false,
  message: "",
  type: "success" as "success" | "error" | "info" | "warning",
});

function showToast(
  message: string,
  type: "success" | "error" | "info" | "warning" = "success",
) {
  toast.value.message = message;
  toast.value.type = type;
  toast.value.visible = true;
  setTimeout(() => {
    toast.value.visible = false;
  }, 4000);
}

const hasActiveFilters = computed(() => {
  return (
    filters.search.trim() !== "" ||
    filters.course !== "All" ||
    filters.status !== "All"
  );
});

function resetFilters() {
  filters.search = "";
  filters.course = "All";
  filters.status = "All";
  filters.sortBy = "id";
  filters.order = "DESC";
}

function toggleSortOrder() {
  filters.order = filters.order === "ASC" ? "DESC" : "ASC";
}

// Fetch Students
async function fetchStudents() {
  try {
    const params: Record<string, string> = {
      sort_by: filters.sortBy,
      order: filters.order,
    };
    if (filters.search) params.search = filters.search;
    if (filters.course && filters.course !== "All")
      params.course = filters.course;
    if (filters.status && filters.status !== "All")
      params.status = filters.status;

    const res: any = await $fetch("/api/students", { params });
    if (res.success) {
      students.value = res.data;
      dbError.value = null;
    }
  } catch (err: any) {
    dbError.value =
      err.data?.statusMessage ||
      err.message ||
      "Could not query students from MySQL";
  }
}

// Fetch Stats
async function fetchStats() {
  try {
    const res: any = await $fetch("/api/stats");
    if (res.success && res.data) {
      stats.total = res.data.total;
      stats.active = res.data.active;
      stats.graduated = res.data.graduated;
      stats.avgGpa = res.data.avgGpa;
      stats.coursesCount = res.data.coursesCount;
    }
  } catch (err: any) {
    console.error("Stats fetch error:", err);
  }
}

async function fetchAll() {
  isLoading.value = true;
  await Promise.all([fetchStudents(), fetchStats()]);
  isLoading.value = false;
}

// Watch filters with debounce
let searchDebounceTimeout: any = null;
watch(
  () => [
    filters.search,
    filters.course,
    filters.status,
    filters.sortBy,
    filters.order,
  ],
  () => {
    clearTimeout(searchDebounceTimeout);
    searchDebounceTimeout = setTimeout(() => {
      fetchStudents();
    }, 250);
  },
);

// Modal Openers
function openCreateModal() {
  editingStudent.value = null;
  isStudentModalOpen.value = true;
}

function openEditModal(student: Student) {
  editingStudent.value = { ...student };
  isStudentModalOpen.value = true;
}

function confirmDelete(student: Student) {
  deletingStudent.value = student;
  isDeleteModalOpen.value = true;
}

// Save Student (Create or Update)
async function handleSaveStudent(formData: any) {
  isSaving.value = true;
  try {
    if (editingStudent.value && editingStudent.value.id) {
      // Update
      const res: any = await $fetch(
        `/api/students/${editingStudent.value.id}`,
        {
          method: "PUT",
          body: formData,
        },
      );
      showToast(res.message || "Student updated successfully!", "success");
    } else {
      // Create
      const res: any = await $fetch("/api/students", {
        method: "POST",
        body: formData,
      });
      showToast(res.message || "Student created successfully!", "success");
    }
    isStudentModalOpen.value = false;
    await fetchAll();
  } catch (err: any) {
    const msg =
      err.data?.statusMessage || err.message || "Failed to save student";
    showToast(msg, "error");
  } finally {
    isSaving.value = false;
  }
}

// Delete Student
async function handleDeleteStudent() {
  if (!deletingStudent.value) return;
  isDeleting.value = true;
  try {
    const res: any = await $fetch(`/api/students/${deletingStudent.value.id}`, {
      method: "DELETE",
    });
    showToast(res.message || "Student deleted successfully", "success");
    isDeleteModalOpen.value = false;
    deletingStudent.value = null;
    await fetchAll();
  } catch (err: any) {
    const msg =
      err.data?.statusMessage || err.message || "Failed to delete student";
    showToast(msg, "error");
  } finally {
    isDeleting.value = false;
  }
}

// Seed Demo Data
async function seedDatabase() {
  isSeeding.value = true;
  try {
    const res: any = await $fetch("/api/seed", { method: "POST" });
    showToast(
      res.message || "Demo students populated into database!",
      "success",
    );
    await fetchAll();
  } catch (err: any) {
    const msg =
      err.data?.statusMessage || err.message || "Failed to seed sample data";
    showToast(msg, "error");
  } finally {
    isSeeding.value = false;
  }
}

// Formatting helpers
function formatDate(dateStr: string) {
  if (!dateStr) return "—";
  try {
    const d = new Date(dateStr);
    return d.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
  } catch {
    return dateStr;
  }
}

const avatarColorPalettes = [
  "bg-blue-100 text-blue-700",
  "bg-purple-100 text-purple-700",
  "bg-emerald-100 text-emerald-700",
  "bg-rose-100 text-rose-700",
  "bg-amber-100 text-amber-700",
  "bg-teal-100 text-teal-700",
  "bg-indigo-100 text-indigo-700",
];

function getAvatarColor(name: string) {
  if (!name) return avatarColorPalettes[0];
  const charCode = name.charCodeAt(0);
  return avatarColorPalettes[charCode % avatarColorPalettes.length];
}

async function checkAuth() {
  isCheckingAuth.value = true;
  try {
    const res: any = await $fetch('/api/auth/me');
    if (res.authenticated && res.user) {
      currentUser.value = res.user;
      await fetchAll();
    } else {
      currentUser.value = null;
    }
  } catch (err) {
    currentUser.value = null;
  } finally {
    isCheckingAuth.value = false;
  }
}

function onAuthSuccess(user: any) {
  currentUser.value = user;
  showToast(`Welcome back, ${user.name}!`, 'success');
  fetchAll();
}

async function handleLogout() {
  try {
    await $fetch('/api/auth/logout', { method: 'POST' });
  } catch {}
  currentUser.value = null;
  showToast('You have been signed out.', 'info');
}

onMounted(() => {
  checkAuth();
});
</script>
